using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace TestPTWebService
{

public partial class MakePaymentStep1 : System.Web.UI.Page
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
                    btnSave.Visible = false;
                    lblErrorMessage.Text = "Invalid Secret Key";
                    return;
                }
            }
            GetCurrencies();
            GetCountries();
        }
    }

    protected void GetCurrencies()
    {
        ddlCurrency.Items.Clear();
        ddlCurrency.Items.Add(new ListItem("US Dollar","USD"));
        ddlCurrency.Items.Add(new ListItem("Euro","EUR"));
        ddlCurrency.Items.Add(new ListItem("Peso","ARS"));
        ddlCurrency.Items.Add(new ListItem("Australian Dollar","AUD"));
        ddlCurrency.Items.Add(new ListItem("Bahraini Dinar","BHD"));
        ddlCurrency.Items.Add(new ListItem("Bangladeshi Taka","BDT"));
        ddlCurrency.Items.Add(new ListItem("Indian Rupee","INR"));
        ddlCurrency.Items.Add(new ListItem("Kuwaiti Dinar","KWD"));
        ddlCurrency.Items.Add(new ListItem("Omani Rial","OMR"));
        ddlCurrency.Items.Add(new ListItem("Qatari Rial	","QAR"));
        ddlCurrency.Items.Add(new ListItem("Russian Ruble","RUB"));
        ddlCurrency.Items.Add(new ListItem("Pound Sterling","GBP"));
        ddlCurrency.Items.Add(new ListItem("Arab Emirates Dirham", "AED"));

    }

    protected void GetCountries()
    {
        ddlShippingCountry.Items.Clear();
        ddlCountry.Items.Clear();

        List<Models.Country> Countries = new List<Models.Country>();
        Countries.Add(new Models.Country {CountryName = "Australia", CountryCode = "AUS" });
        Countries.Add(new Models.Country {CountryName ="Bahrain", CountryCode ="BHR" });
        Countries.Add(new Models.Country {CountryName ="Bangladesh",CountryCode = "BGD" });
        Countries.Add(new Models.Country {CountryName ="Canada",CountryCode ="CAN" });
        Countries.Add(new Models.Country {CountryName ="China", CountryCode ="CHN" });
        Countries.Add(new Models.Country {CountryName ="France", CountryCode ="FRA" });
        Countries.Add(new Models.Country {CountryName ="Germany", CountryCode ="DEU" });
        Countries.Add(new Models.Country {CountryName ="India", CountryCode ="IND" });
        Countries.Add(new Models.Country {CountryName ="Italy", CountryCode ="ITA" });
        Countries.Add(new Models.Country {CountryName ="Kuwait", CountryCode ="KWT" });
        Countries.Add(new Models.Country {CountryName ="Oman", CountryCode ="OMN" });
        Countries.Add(new Models.Country {CountryName ="Saudi Arabia", CountryCode ="SAU" });
        Countries.Add(new Models.Country {CountryName ="Spain", CountryCode ="ESP" });
        Countries.Add(new Models.Country {CountryName ="Sri Lanka", CountryCode ="LKA" });
        Countries.Add(new Models.Country {CountryName = "United States of America", CountryCode = "USA" });

        ddlShippingCountry.DataSource = Countries;
        ddlShippingCountry.DataTextField = "CountryName";
        ddlShippingCountry.DataValueField = "CountryCode";
        ddlShippingCountry.DataBind();

        ddlCountry.DataSource = Countries;
        ddlCountry.DataTextField = "CountryName";
        ddlCountry.DataValueField = "CountryCode";
        ddlCountry.DataBind();
    }

    protected void btnSave_click(object sender, EventArgs e)
    {
        var objrequest = new Models.PayPageRequest();
        var tmp = new Models.PayPageResponse();
        try
        {
            var paymentUtility = new Utility();
            objrequest = CreatePayPage();

            //Log to File
            Logger.Info("MakePaymentStep1 - Start", "btnSave_click", objrequest);

            string serviceResponse = paymentUtility.MakeWebServiceCall(Utility.ConstCreatePayPage, paymentUtility.CreatePayPage(objrequest));
            tmp = JsonConvert.DeserializeObject<Models.PayPageResponse>(serviceResponse);

            //Log Response to File
            Logger.Info("MakePaymentStep1 - End", "btnSave_click", tmp);

            if (tmp.response_code != null && tmp.response_code != "4012")
            {
                lblErrorMessage.Text = paymentUtility.GetPayTabResponseMessage(Utility.PayTabRequestType.CreatePayPage, tmp.response_code, tmp.result);
            }
            else if (tmp.payment_url != "")
            {
                //Set Payment Active URL to session
//                var activeClient = (Models.Settings)Session["ActiveClient"];
                Helper.PayTabsSession.CurrentActivePaymentID = tmp.payment_url;
                Helper.PayTabsSession.LastPaymentReferenceNumber = tmp.p_id;
                Helper.PayTabsSession.PageRequestList = new List<Models.PayPageRequest>();
                objrequest.PaymentReference = tmp.p_id;

                var paymentList = new Models.PaymentsList();
                paymentList.PayPageRequests = new List<Models.PayPageRequest>();
                if (HttpRuntime.Cache["PAYTABS_PAYMENTS"] != null)
                {
                    paymentList = HttpRuntime.Cache["PAYTABS_PAYMENTS"] as Models.PaymentsList;

                    //Remove the Old
                    HttpRuntime.Cache.Remove("PAYTABS_PAYMENTS");
                }

                paymentList.PayPageRequests.Add(objrequest);

                HttpRuntime.Cache.Insert("PAYTABS_PAYMENTS", paymentList, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(60));

                Helper.PayTabsSession.PageRequestList.Add(objrequest);
                
                //Redirect to Hosted Page
                Response.Redirect("~/ClientHost.aspx");
            }
        }
        catch (System.Net.WebException ex)
        {
            //Log Response to File
            Logger.Info("MakePaymentStep1 - Exception", "btnSave_click", ex);

            if (ex.Message.Contains("The remote name could not be resolved"))
            {
                lblErrorMessage.Text = ex.Message;
            }
        }
        catch (Exception ex)
        {
            //Log Response to File
            Logger.Info("MakePaymentStep1 - Exception", "btnSave_click", ex);
        }
    }
 
    protected Models.PayPageRequest CreatePayPage()
    {
        if (Helper.PayTabsSession.EmailAddress == null)
        {
            Response.Redirect("~/ClientSettings.aspx");
            return null;
        }
        else
        {
            var objRequest = new Models.PayPageRequest
            {
                MerchantEmail = Helper.PayTabsSession.EmailAddress,
                SecretKey = Helper.PayTabsSession.SecretKey,
                Currency = ddlCurrency.SelectedValue,
                Amount = hdnTotalAmount.Value,
                SiteUrl = Helper.PayTabsSession.SiteUrl,
                Title = txtProduct.Text,
                Quantity = txtQuantity.Text,
                UnitPrice = txtPrice.Text,
                ProductsPerTitle = txtProduct.Text,
                ReturnUrl = Helper.PayTabsSession.SiteUrl + "/Receipt.aspx",
                CcFirstNname = txtFirstName.Text,
                CcLastName = txtLastName.Text,
                Phonenumber = txtPhone.Text,
                CcPhoneNumber = txtPhone.Text,
                BillingAddress = txtAddress1.Text,
                City = txtCity.Text,
                State = txtState.Text,
                PostalCode = txtZipCode.Text,
                Country = ddlCountry.SelectedValue,
                Email = txtEmailAddress.Text,
                AddressShipping = txtShippingAddress.Text,
                CityShipping = txtShippingCity.Text,
                StateShipping = txtShippingState.Text,
                PostalCodeShipping = txtShippingZipCode.Text,
                CountryShipping = ddlShippingCountry.SelectedValue,
                PaymentDate = DateTime.Now.Date
            };

            return objRequest;
        }

    }

}

}