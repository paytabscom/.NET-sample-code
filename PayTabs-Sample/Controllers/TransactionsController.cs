using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PayTabs_Sample.Data;
using PayTabs_Sample.Helpers;
using PayTabs_Sample.Models;

namespace PayTabs_Sample.Controllers;

public class TransactionsController : Controller
{
	private readonly PayTabs_SampleContext _context;

	public TransactionsController(PayTabs_SampleContext context)
	{
		_context = context;
	}

	// GET: Transactions
	public async Task<IActionResult> Index()
	{
		return View(await _context.Transaction.ToListAsync());
	}

	// GET: Transactions/Details/5
	public async Task<IActionResult> Details(int? id)
	{
		if (id == null) return NotFound();

		var transaction = await _context.Transaction
			.FirstOrDefaultAsync(m => m.Id == id);
		if (transaction == null) return NotFound();

		return View(transaction);
	}

	// GET: Transactions/Create
	public IActionResult Create()
	{
		return View();
	}

	// POST: Transactions/Create
	[HttpPost]
	[ValidateAntiForgeryToken]
	public async Task<IActionResult> Create(
		[Bind(
			"Id,ProfileId,Endpoint,ServerKey,TranType,TranClass,CartId,CartCurrency,CartAmount,CartDescription,PaypageLang,HideShipping,IsFramed,ReturnURL,CallbackURL")]
		Transaction transaction)
	{
		if (ModelState.IsValid)
		{
			_context.Add(transaction);
			await _context.SaveChangesAsync();
			return RedirectToAction(nameof(Index));
		}

		return View(transaction);
	}


	// GET: Transactions/Delete/5
	public async Task<IActionResult> Delete(int? id)
	{
		if (id == null) return NotFound();

		var transaction = await _context.Transaction
			.FirstOrDefaultAsync(m => m.Id == id);
		if (transaction == null) return NotFound();

		return View(transaction);
	}

	// POST: Transactions/Delete/5
	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	public async Task<IActionResult> DeleteConfirmed(int id)
	{
		var transaction = await _context.Transaction.FindAsync(id);
		_context.Transaction.Remove(transaction);
		await _context.SaveChangesAsync();
		return RedirectToAction(nameof(Index));
	}

	private bool TransactionExists(int id)
	{
		return _context.Transaction.Any(e => e.Id == id);
	}


	//

	public async Task<Transaction_Response> Pay(int id)
	{
		var transaction = await _context.Transaction
			.FirstOrDefaultAsync(m => m.Id == id);
		if (transaction == null) return null; // NotFound();

		var c = new Connector();
		var r = c.Send(transaction);

		if (r.IsSuccess())
		{
			transaction.Tran_Ref = r.tran_ref;
			transaction.TriedToPay = true;

			_context.Update(transaction);
			await _context.SaveChangesAsync();

			Response.Redirect(r.redirect_url);
		}

		return r; // RedirectToAction(nameof(Details), new { id });
	}

	//

	[HttpPost]
	public async Task<IActionResult> Webhook([FromForm] Transaction_Result content)
	{
		var transaction = await _context.Transaction
			.FirstOrDefaultAsync(m => m.CartId == content.cartId);

		if (transaction == null) return NotFound();

		var valid = content.IsValid_Signature(transaction.ServerKey);

		transaction.IsValid_Signature = valid;
		transaction.IsSucceed = content.IsSucceed();

		_context.Update(transaction);
		await _context.SaveChangesAsync();


		return View(content);
	}

	//

	[HttpPost]
	public void IPN([FromBody] Transaction_IPN ipn)
	{
		//using var reader = new StreamReader(Request.Body);
		//var body = await reader.ReadToEndAsync();
		//System.Console.WriteLine(body);
		//return body;

		Console.WriteLine(ipn);
	}
}
