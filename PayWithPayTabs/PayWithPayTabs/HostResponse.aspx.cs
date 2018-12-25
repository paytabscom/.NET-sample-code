using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace TestPTWebService
{

    public partial class HostResponse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (HttpContext.Current != null && HttpContext.Current.Response.StatusCode == 200)
                {
                    GetLastPaymentDetails();
                }
            }
        }

        protected void GetLastPaymentDetails()
        {
            WebClient client = new WebClient();
            client.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";

            //var activeClient = (Models.Settings) Session["ActiveClient"];

            string response = client.UploadString("https://www.paytabs.com/apiv2/verify_payment",
                "secret_key=" + Helper.PayTabsSession.SecretKey
                + "&merchant_email=" + Helper.PayTabsSession.EmailAddress
                + "&merchant_password=" + Helper.PayTabsSession.Password
                + "&payment_reference=" + Helper.PayTabsSession.LastPaymentReferenceNumber);

            Models.PayTabsVerifyPaymentResponse PTResp = JsonConvert.DeserializeObject<Models.PayTabsVerifyPaymentResponse>(response);

            ClientScript.RegisterStartupScript(GetType(), "Load",
                "<script type='text/javascript'>window.parent.location.href = 'Receipt.aspx'; </script>");

        }
    }


}