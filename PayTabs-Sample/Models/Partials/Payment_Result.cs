using System;

namespace PayTabs_Sample.Models;

public class Payment_Result
{
	public string response_status { get; set; }
	public string response_code { get; set; }
	public string response_message { get; set; }

	public string cvv_result { get; set; }
	public string avs_result { get; set; }

	public DateTime transaction_time { get; set; }
}
