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
    public partial class VerifyIPN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["ActiveClient"] == null)
                {
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    if (((Models.Settings)Session["ActiveClient"]).InvalidSecretKey)
                    {
                        string error = "Invalid Secret Key";
                        return;
                    }
                }
            }
        }

        protected void GetLastPaymentDetails()
        {
            //Log to File
            Logger.Info("VerifyIPN -Start", "GetLastPaymentDetails", "");

        }
    }
}