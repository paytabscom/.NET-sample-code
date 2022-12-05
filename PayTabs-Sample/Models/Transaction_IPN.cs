namespace PayTabs_Sample.Models;

public class Transaction_IPN
{
	public int merchant_id { get; set; }
	public int profile_id { get; set; }

	public string tran_ref { get; set; }
	public string tran_type { get; set; }

	public string cart_id { get; set; }
	public float cart_amount { get; set; }
	public string cart_currency { get; set; }
	public string cart_description { get; set; }

	public string tran_class { get; set; }
	public string tran_currency { get; set; }
	public float tran_total { get; set; }

	public CustomerDetails customer_details { get; set; }

	public Payment_Result payment_result { get; set; }

	public Payment_Info payment_info { get; set; }
}
