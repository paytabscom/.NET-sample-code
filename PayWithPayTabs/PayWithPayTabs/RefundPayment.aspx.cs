using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

public partial class RefundPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Helper.PayTabsSession.EmailAddress != null)
            {
                if (Helper.PayTabsSession.InvalidSecretKey)
                {
                    btnDoRefund.Visible = false;
                    lblErrorMessage.Text = "Invalid Secret Key";
                    return;
                }

                SetDefaults();
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
 
    }

    protected void btnDoRefund_click(object sender, EventArgs e)
    {
        try
        {
            var paymentUtility = new Utility();

            var objrefundRequest = CreateRefundRequest();

            //Log to File
            Logger.Info("RefundPayment - Start", "btnDoRefund_click", objrefundRequest);

            string serviceResponse = paymentUtility.MakeWebServiceCall(Utility.ConstRefundProcess, paymentUtility.MakeRefund(objrefundRequest));

            var tmp = JsonConvert.DeserializeObject<Models.PayPageResponse>(serviceResponse);

            //Log to File
            Logger.Info("RefundPayment - End", "btnDoRefund_click", tmp);

            if (tmp.response_code != null && tmp.response_code != "0")
            {
                lblErrorMessage.Text = paymentUtility.GetPayTabResponseMessage(Utility.PayTabRequestType.CreatePayPage, tmp.response_code, tmp.result);
            }
            else if (tmp.payment_url != "")
            {
                //Set Payment Active URL to session
                //var activeClient = (Models.Settings)Session["ActiveClient"];
                Helper.PayTabsSession.CurrentActivePaymentID = tmp.payment_url;
                Helper.PayTabsSession.LastPaymentReferenceNumber = tmp.p_id;
                //Session["ActiveClient"] = activeClient;

                //Redirect to Hosted Page
                Response.Redirect("~/ClientHost.aspx");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        
       
    }

    protected Models.RefundRequest CreateRefundRequest()
    {
        //var activeClient = (Models.Settings)Session["ActiveClient"];

        if (Helper.PayTabsSession.EmailAddress == null)
        {
            Response.Redirect("~/ClientSettings.aspx");
            return null;
        }
        else
        {
            var objRequest = new Models.RefundRequest()
            {
                MerchantEmail = Helper.PayTabsSession.EmailAddress,
                SecretKey = Helper.PayTabsSession.SecretKey,
                RefundAmount = txtRefundAmount.Text,
                RefundReason = txtRefundReason.Text,
                PageId = txtPageId.Text
            };

            return objRequest;
        }

    }

    protected void SetDefaults()
    {
        
    }
}