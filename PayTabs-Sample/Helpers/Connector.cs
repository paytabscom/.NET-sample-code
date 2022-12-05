using Newtonsoft.Json;
using PayTabs_Sample.Models;
using RestSharp;
using RestSharp.Serialization.Json;

namespace PayTabs_Sample.Helpers;

public class Connector
{
	public Transaction_Response Send(Transaction transaction)
	{
		var base_url = transaction.Endpoint; // "https://secure.paytabs.com/";
		var payment_url = base_url + "payment/request";

		var body = JsonConvert.SerializeObject(transaction);

		var client = new RestClient(payment_url);
		//client.UseJson();
		//client.AddHandler("applications/json", )

		var request = new RestRequest(Method.POST);
		request.AddHeader("authorization", transaction.ServerKey);
		request.AddParameter("text/plain", body, ParameterType.RequestBody);
		//request.AddJsonBody(transaction);

		var response = client.Execute(request);

		var tran_res = new JsonDeserializer().Deserialize<Transaction_Response>(response);


		return tran_res;
	}
}
