using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Newtonsoft.Json;

namespace TestPTWebService
{

    public partial class ClientSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadClientSetting();
            }
        }

        protected void btnSave_click(object sender, EventArgs e)
        {

        }

        protected void LoadClientSetting()
        {
            XElement xelement = XElement.Load(HttpContext.Current.Server.MapPath("~/Client.xml"));

            string baseURL = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

            var urlList = xelement.Descendants().Select(nd => new Models.Settings
            {
                Name = nd.Attribute("Name").Value,
                SecretKey = nd.Attribute("SecretKey").Value,
                EmailAddress = nd.Attribute("EmailAddress").Value.ToUpper(),
                Password = nd.Attribute("Password").Value,
                SiteUrl = baseURL, // nd.Attribute("Website").Value,
            }).ToList();

            txtClientName.Text = urlList[0].Name;
            txtSecretKey.Text = urlList[0].SecretKey;
            txtEmailAddress.Text = urlList[0].EmailAddress;
            txtPassword.Text = urlList[0].Password;
            txtWebSite.Text = urlList[0].SiteUrl;

            Session["ActiveClient"] = urlList[0];
            Helper.PayTabsSession.Name = urlList[0].Name;
            Helper.PayTabsSession.SecretKey = urlList[0].SecretKey;
            Helper.PayTabsSession.EmailAddress = urlList[0].EmailAddress;
            Helper.PayTabsSession.Password = urlList[0].Password;
            Helper.PayTabsSession.SiteUrl = urlList[0].SiteUrl;
            
            //Log to File
            Logger.Info("ClientSettings - End - XML Load", "LoadClientSetting", "Client" + urlList[0].Name);

        }

        protected void btnValidateKey_click(object sender, EventArgs e)
        {
          
                var objRequest = new Models.VerifySecretKeyRequest()
                {
                    MerchantEmail = Helper.PayTabsSession.EmailAddress.ToLower(),
                    SecretKey = Helper.PayTabsSession.SecretKey,
                };

                var paymentUtility = new Utility();

                //Log to File
                Logger.Info("ValidateKey Request - Start", "btnValidateKey_click", "ClientLis loaded");

                string serviceResponse = "";
                var tmp = new Models.VerifySecretKeyResponse();

                try
                {
                    serviceResponse = paymentUtility.MakeWebServiceCall(Utility.ConstValidateKey, paymentUtility.ValidateSecretKey(objRequest));
                    string requestFromPost = "{'status':'success','transaction_id':'40640','transaction_title':'Pen','amount':'18.00','currency':'USD','datetime':'12-07-2016 04:03:04'},{'status':'failed','transaction_id':'40637','transaction_title':'mobile','amount':'499.00','currency':'USD','datetime':'12-07-2016 03:48:18'},{'status':'success','transaction_id':'40534','transaction_title':'Lipstick','amount':'72.00','currency':'USD','datetime':'11-07-2016 05:11:41'},{'status':'success','transaction_id':'40533','transaction_title':'Lipstick','amount':'18.00','currency':'USD','datetime':'11-07-2016 05:09:51'},{'status':'success','transaction_id':'40532','transaction_title':'Ring','amount':'398.00','currency':'USD','datetime':'11-07-2016 05:03:43'},{'status':'success','transaction_id':'40398','transaction_title':'testapp','amount':'72.00','currency':'USD','datetime':'09-07-2016 03:25:11'},{'status':'success','transaction_id':'40382','transaction_title':'VOSS','amount':'36.00','currency':'USD','datetime':'09-07-2016 01:07:37'},{'status':'failed','transaction_id':'40305','transaction_title':'Vaseline','amount':'60.00','currency':'USD','datetime':'07-07-2016 06:42:10'},{'status':'success','transaction_id':'40303','transaction_title':'Racket','amount':'240.00','currency':'USD','datetime':'07-07-2016 05:41:14'},{'status':'success','transaction_id':'40302','transaction_title':'Tablet','amount':'144.00','currency':'USD','datetime':'07-07-2016 05:38:04'},{'status':'failed','transaction_id':'40301','transaction_title':'testapp','amount':'60.00','currency':'USD','datetime':'07-07-2016 04:13:56'},{'status':'success','transaction_id':'40261','transaction_title':'testapp','amount':'660.00','currency':'USD','datetime':'07-07-2016 11:07:45'},{'status':'success','transaction_id':'40260','transaction_title':'PC','amount':'22.00','currency':'USD','datetime':'07-07-2016 11:02:43'},{'status':'success','transaction_id':'40117','transaction_title':'testapp','amount':'330.00','currency':'USD','datetime':'04-07-2016 04:55:03'},{'status':'success','transaction_id':'39978','transaction_title':'Vaseline','amount':'12.00','currency':'USD','datetime':'01-07-2016 05:55:29'},{'status':'success','transaction_id':'39977','transaction_title':'Laptop','amount':'799.00','currency':'USD','datetime':'01-07-2016 05:43:13'},{'status':'success','transaction_id':'39975','transaction_title':'Tablet','amount':'299.00','currency':'USD','datetime':'01-07-2016 05:08:14'},{'status':'success','transaction_id':'39879','transaction_title':'Racket','amount':'21.00','currency':'INR','datetime':'30-06-2016 11:48:15'},{'status':'success','transaction_id':'39831','transaction_title':'Vaseline','amount':'240.00','currency':'USD','datetime':'29-06-2016 03:14:58'},{'status':'success','transaction_id':'39829','transaction_title':'Racket','amount':'144.00','currency':'USD','datetime':'29-06-2016 03:04:56'},{'status':'success','transaction_id':'39705','transaction_title':'Demo Product','amount':'3.00','currency':'USD','datetime':'28-06-2016 07:21:04'}";
                    //serviceResponse = paymentUtility.MakeWebSiteCallFromHandler(requestFromPost);

                    tmp = JsonConvert.DeserializeObject<Models.VerifySecretKeyResponse>(serviceResponse);
                    if (tmp.response_code != null)
                    {
                        lblErrorMessage.Text = paymentUtility.GetPayTabResponseMessage(Utility.PayTabRequestType.ValidateSecretKey, tmp.response_code, tmp.result);
                    }

                    if (tmp.response_code != null && tmp.response_code != "4000")
                    {
                        Helper.PayTabsSession.InvalidSecretKey = true;
                    }
                    if (tmp.response_code != null && tmp.response_code == "4000" && Helper.PayTabsSession.InvalidSecretKey)
                    {
                        Helper.PayTabsSession.InvalidSecretKey = false;
                    }
                }
                catch (Exception ex)
                {
                   Logger.Info("ValidateKey Error", "btnValidateKey_click", "Error:" + ex.Message) ;
                    lblErrorMessage.Text = "Error Validating key";
                }
                
                //Log to File
                Logger.Info("ValidateKey Response End", "btnValidateKey_click", "Client" + tmp);

            
        }
        
    }

}