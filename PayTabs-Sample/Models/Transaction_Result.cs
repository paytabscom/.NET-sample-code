using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using Newtonsoft.Json;

namespace PayTabs_Sample.Models;

public class Transaction_Result
{
	public string tranRef { get; set; }

	public string respCode { get; set; }
	public string respMessage { get; set; }
	public string respStatus { get; set; }

	public string acquirerMessage { get; set; }
	public string acquirerRRN { get; set; }

	public string cartId { get; set; }
	public string customerEmail { get; set; }

	public string signature { get; set; }

	public string token { get; set; }


	//

	public bool IsValid_Signature(string server_key)
	{
		var dic = ToDictionary();

		// 1 : Remove Signature parameter

		var signature = dic["signature"];
		dic.Remove("signature");


		// 2 : Remove Empty parameters
		dic = dic
			.Where(k => k.Value != null && k.Value.Trim().Length > 0)
			.ToDictionary(x => x.Key, x => x.Value);


		// 3 : Sort the Parameters ASC

		dic = dic
			.OrderBy(x => x.Key)
			.ToDictionary(x => x.Key, x => x.Value);


		// 4 : Merge the parameters as one String, Encode the values with URL_Encoder

		var query = string.Join("&", dic.Select(x => x.Key + "=" + WebUtility.UrlEncode(x.Value)).ToArray());


		// 5 : Compute the Hash

		using (var hmac = new HMACSHA256(Encoding.UTF8.GetBytes(server_key)))
		{
			var hashed = hmac.ComputeHash(Encoding.UTF8.GetBytes(query));

			var builder = new StringBuilder();
			for (var i = 0; i < hashed.Length; i++) builder.Append(hashed[i].ToString("x2"));
			var hashed_str = builder.ToString();

			return hashed_str.Equals(signature);
		}
	}

	//

	public bool IsSucceed()
	{
		return respStatus.Equals("A");
	}

	//

	private Dictionary<string, string> ToDictionary()
	{
		var json = JsonConvert.SerializeObject(this);
		var dictionary = JsonConvert.DeserializeObject<Dictionary<string, string>>(json);

		return dictionary;
	}
}
