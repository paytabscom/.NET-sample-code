using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IPNListener : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Console.WriteLine("Any Message ?");
        if (!Page.IsPostBack)
        {
            System.IO.StreamReader reader = new System.IO.StreamReader(HttpContext.Current.Request.InputStream);
            string requestFromPost = reader.ReadToEnd();

            txtData.Text = requestFromPost;
            
            //Log to File
            Logger.Info("IPNListener - Request.Form - Log", "IPNListener", requestFromPost);
        }
    }


    //public override CapturePaymentResult Capture(CapturePaymentRequest capturePaymentRequest)
    //{
    //    var result = new CapturePaymentResult
    //    {
    //        NewPaymentStatus = capturePaymentRequest.Order.PaymentStatus
    //    };

    //    var webClient = new WebClient();
    //    var form = new NameValueCollection();
    //    var store = _services.StoreService.GetStoreById(capturePaymentRequest.Order.StoreId);

    //    form.Add("x_login", _authorizeNetPaymentSettings.LoginId);
    //    form.Add("x_tran_key", _authorizeNetPaymentSettings.TransactionKey);
    //    if (_authorizeNetPaymentSettings.UseSandbox)
    //        form.Add("x_test_request", "TRUE");
    //    else
    //        form.Add("x_test_request", "FALSE");

    //    form.Add("x_delim_data", "TRUE");
    //    form.Add("x_delim_char", "|");
    //    form.Add("x_encap_char", "");
    //    form.Add("x_version", GetApiVersion());
    //    form.Add("x_relay_response", "FALSE");
    //    form.Add("x_method", "CC");
    //    form.Add("x_currency_code", store.PrimaryStoreCurrency.CurrencyCode);
    //    form.Add("x_type", "PRIOR_AUTH_CAPTURE");

    //    var orderTotal = Math.Round(capturePaymentRequest.Order.OrderTotal, 2);
    //    form.Add("x_amount", orderTotal.ToString("0.00", CultureInfo.InvariantCulture));
    //    string[] codes = capturePaymentRequest.Order.AuthorizationTransactionCode.Split(',');
    //    //x_trans_id. When x_test_request (sandbox) is set to a positive response, 
    //    //or when Test mode is enabled on the payment gateway, this value will be "0".
    //    form.Add("x_trans_id", codes[0]);

    //    string reply = null;
    //    Byte[] responseData = webClient.UploadValues(GetAuthorizeNETUrl(), form);
    //    reply = Encoding.ASCII.GetString(responseData);

    //    if (!String.IsNullOrEmpty(reply))
    //    {
    //        string[] responseFields = reply.Split('|');
    //        switch (responseFields[0])
    //        {
    //            case "1":
    //                result.CaptureTransactionId = string.Format("{0},{1}", responseFields[6], responseFields[4]);
    //                result.CaptureTransactionResult = string.Format("Approved ({0}: {1})", responseFields[2], responseFields[3]);
    //                //result.AVSResult = responseFields[5];
    //                //responseFields[38];
    //                result.NewPaymentStatus = PaymentStatus.Paid;
    //                break;
    //            case "2":
    //                result.AddError(string.Format("Declined ({0}: {1})", responseFields[2], responseFields[3]));
    //                break;
    //            case "3":
    //                result.AddError(string.Format("Error: {0}", reply));
    //                break;
    //        }
    //    }
    //    else
    //    {
    //        result.AddError("Authorize.NET unknown error");
    //    }

    //    return result;
    //}

    //public override IList<string> ValidatePaymentForm(FormCollection form)
    //{
    //    var warnings = new List<string>();

    //    //validate
    //    var validator = new PaymentInfoValidator(_localizationService);
    //    var model = new PaymentInfoModel()
    //    {
    //        CardholderName = form["CardholderName"],
    //        CardNumber = form["CardNumber"],
    //        CardCode = form["CardCode"],
    //        ExpireMonth = form["ExpireMonth"],
    //        ExpireYear = form["ExpireYear"]
    //    };
    //    var validationResult = validator.Validate(model);
    //    if (!validationResult.IsValid)
    //        foreach (var error in validationResult.Errors)
    //            warnings.Add(error.ErrorMessage);
    //    return warnings;
    //}

}