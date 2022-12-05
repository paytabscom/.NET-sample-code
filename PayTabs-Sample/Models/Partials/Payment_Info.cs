namespace PayTabs_Sample.Models;

public class Payment_Info
{
	public string payment_method { get; set; }

	public string card_type { get; set; }
	public string card_scheme { get; set; }
	public string payment_description { get; set; }

	public int expiryYear { get; set; }
	public int expiryMonth { get; set; }

	public string IssuerCountry { get; set; }
	public string IssuerName { get; set; }
}
