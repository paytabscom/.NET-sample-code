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

public partial class ClientHost : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           DisplayHostedPage();    
        }
    }

    protected void DisplayHostedPage()
    {

       // var activeClient = (Models.Settings)Session["ActiveClient"];

        if (Helper.PayTabsSession.EmailAddress == null)
        {
            Response.Redirect("~/ClientSettings.aspx");
        }

        if (Helper.PayTabsSession.CurrentActivePaymentID != "")
        {
            //Log to File
            Logger.Info("ClientHost - Start", "DisplayHostedPage", Helper.PayTabsSession.CurrentActivePaymentID);

            iFramePayment.Attributes.Add("src", Helper.PayTabsSession.CurrentActivePaymentID);
        }
        else
        {
            lblErrorMessage.Text = "Some Error has Occured, Please try the transaction again.";
            
            //Log to File
            Logger.Info("ClientHost - Error", "DisplayHostedPage", Helper.PayTabsSession.CurrentActivePaymentID);
        }
    }

}

}