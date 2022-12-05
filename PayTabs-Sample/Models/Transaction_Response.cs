namespace PayTabs_Sample.Models;

public class Transaction_Response
{
	public string tran_ref { get; set; }
	public string redirect_url { get; set; }


	public bool IsSuccess()
	{
		if (string.IsNullOrWhiteSpace(tran_ref) || string.IsNullOrWhiteSpace(redirect_url)) return false;

		return true;
	}
}
