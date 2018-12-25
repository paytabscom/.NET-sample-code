using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PaymentsDoneToday : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Helper.PayTabsSession.EmailAddress != null)
            {
                GetPaymentsDoneToday();

                if (Helper.PayTabsSession.InvalidSecretKey)
                {
                    string error = "Invalid Secret Key";
                }
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }

    protected void GetPaymentsDoneToday()
    {
        //Log to File
        Logger.Info("PaymentsDoneToday - Start", "GetPaymentsDoneToday", "");

        var paymentsDoneToday = new Models.PaymentsList();
        var paymentsInfoList = new List<Models.PaymentsInfo>();

        if (HttpRuntime.Cache["PAYTABS_PAYMENTS"] != null)
        {
            paymentsDoneToday = HttpRuntime.Cache["PAYTABS_PAYMENTS"] as Models.PaymentsList;
        }

        if (paymentsDoneToday != null && paymentsDoneToday.PayPageRequests != null)
        {
            paymentsInfoList = paymentsDoneToday.PayPageRequests
                .Select(x => new Models.PaymentsInfo
                {
                    Name = x.CcFirstNname + ' ' + x.CcLastName,
                    Amount = x.Currency + x.Amount,
                    Email = x.Email,
                    AddressShipping = x.AddressShipping + "," + x.StateShipping + "," + x.CountryShipping
                }).ToList();
        }

        lvPaymentsToday.DataSource = paymentsInfoList;
        lvPaymentsToday.DataBind();

        //Log to File
        Logger.Info("PaymentsDoneToday - End", "GetPaymentsDoneToday", paymentsDoneToday);
       
    }
}