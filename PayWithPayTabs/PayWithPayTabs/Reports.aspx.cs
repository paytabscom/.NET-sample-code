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
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Helper.PayTabsSession.EmailAddress == null)
                {
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    if (Helper.PayTabsSession.InvalidSecretKey)
                    {
                        btnFindReport.Visible = false;
                        lblErrorMessage.Text = "Invalid Secret Key";
                        return;
                    }
                }
            }
        }

        protected void GetLastPaymentDetails()
        {

        }

        private class Record
        {
            public string Name { set; get; }
            public string Email { set; get; }
            public string AddressShipping { set; get; }
            public int Amount { set; get; }
            public string MoreDetails { set; get; }
        }

        protected void btnFindReport_click(object sender, EventArgs e)
        {
		    //var activeClient = (Models.Settings)Session["ActiveClient"];
            if (Helper.PayTabsSession.EmailAddress == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            var objRequest = new Models.ReportRequest()
            {
                MerchantEmail = Helper.PayTabsSession.EmailAddress,
                SecretKey = Helper.PayTabsSession.SecretKey,
                StartDate = txtReportFromDate.Text,
                EndDate = txtReportToDate.Text
            };

            //Log to File
            Logger.Info("Report -Start", "btnFindReport_click", objRequest);

            var paymentUtility = new Utility();
            string serviceResponse = paymentUtility.MakeWebServiceCall(Utility.ConstTransactionReports, paymentUtility.ReturnTransactionReport(objRequest));

            var reportResults = JsonConvert.DeserializeObject<List<Models.ReportResponse>>(Helper.PayTabsSession.ReportSearchResult); 

            //Log to File
            Logger.Info("Report - End", "btnFindReport_click", serviceResponse);

            lvReports.DataSource = reportResults;
            lvReports.DataBind();
        }
    }
}