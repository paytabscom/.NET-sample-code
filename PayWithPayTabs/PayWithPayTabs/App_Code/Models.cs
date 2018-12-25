using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Models
/// </summary>
public class Models
{
	public Models()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public class Settings 
    {
        public string Name { get; set; }
        public string SecretKey { get; set; }
        public bool InvalidSecretKey { get; set; }
        public string EmailAddress { get; set; }
        public string Password { get; set; }
        public string SiteUrl { get; set; }
        public string LastPaymentReferenceNumber { get; set; }
        public string CurrentActivePaymentID { get; set; }
        public List<PayPageRequest> PageRequestList { get; set; }
    }

    public class PayTabsVerifyPaymentResponse
    {
        public string result { get; set; }
        public string response_code { get; set; }
        public string error_code { get; set; }
        public string pt_invoice_id { get; set; }
        public string amount { get; set; }
        public string currency { get; set; }
        public string reference_no { get; set; }
        public string transaction_id { get; set; }
    }

    public class PayTabsCreatePaymentResponse
    {
        public string result { get; set; }
        public string response_code { get; set; }
        public string payment_url { get; set; }
        public string p_id { get; set; }
        public string error_code { get; set; }
    }

    public class VerifySecretKeyRequest
    {
        public string MerchantEmail { get; set; }
        public string SecretKey { get; set; }
    }

    public class VerifySecretKeyResponse
    {
        public string result { get; set; }
        public string response_code { get; set; }
    }

    public class VerifyPaymentRequest
    {
        public string MerchantEmail { get; set; }
        public string MerchantPassword { get; set; }
        public string ReferenceNumber { get; set; }
        public string SecretKey { get; set; }
    }

    public class VerifyPaymentResponse
    {
        public string result { get; set; }
        public string response_code { get; set; }
        public string error_code { get; set; }
        public string pt_invoice_id { get; set; }
        public string amount { get; set; }
        public string currency { get; set; }
        public string reference_no { get; set; }
        public string transaction_id { get; set; }

        public string shipping_address { get; set; }
        public string shipping_city { get; set; }
        public string shipping_country { get; set; }
        public string shipping_state { get; set; }
        public string shipping_postalcode { get; set; }
        public string phone_num { get; set; }
        public string customer_name { get; set; }
        public string email { get; set; }
        public string detail { get; set; }
        public string reference_id { get; set; }
        public string invoice_id { get; set; }
    }

    public class ReportRequest
    {
        public string MerchantEmail { get; set; }
        public string SecretKey { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }

    public class RefundRequest
    {
        public string MerchantEmail { get; set; }
        public string SecretKey { get; set; }
        public string PageId { get; set; }
        public string RefundAmount { get; set; }
        public string RefundReason { get; set; }
    }

    public class RefundResponse
    {
        public string MerchantEmail { get; set; }
        public string MerchantPassword { get; set; }
        public string PageId { get; set; }
        public string RefundAmount { get; set; }
        public string RefundReason { get; set; }
    }

    public class Country
    {
        public string CountryName { get; set; }
        public string CountryCode { get; set; }
    }

    public class PayPageRequest
    {
        public string MerchantEmail { get; set; }
        public string SecretKey { get; set; }
        public string Currency { get; set; }
        public string Amount { get; set; }
        public string SiteUrl { get; set; }
        public string Title { get; set; }
        public string Quantity { get; set; }
        public string UnitPrice { get; set; }
        public string ProductsPerTitle { get; set; }
        public string ReturnUrl { get; set; }
        public string CcFirstNname { get; set; }
        public string CcLastName { get; set; }
        public string CcPhoneNumber { get; set; }
        public string Phonenumber { get; set; }
        public string BillingAddress { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public string Email { get; set; }
        public string AddressShipping { get; set; }
        public string CityShipping { get; set; }
        public string StateShipping { get; set; }
        public string PostalCodeShipping { get; set; }
        public string CountryShipping { get; set; }
        public string PaymentReference { get; set; }
        public DateTime PaymentDate { get; set; }
    }

    public class PayPageResponse
    {
        public string result { get; set; }
        public string response_code { get; set; }
        public string payment_url { get; set; }
        public string p_id { get; set; }
        public string error_code { get; set; }
    }

    public class PayTabsMakePaymentResponse
    {
        public string message { get; set; }
        public string response { get; set; }
        public string error_code { get; set; }
        public string payment_url { get; set; }
        public string api_key { get; set; }
    }

    public class PaymentsInfo
    {
        public string Name { get; set; }
        public string Amount { get; set; }
        public string Email { get; set; }
        public string AddressShipping { get; set; }
    }

    public class PaymentsList
    {
        public List<PayPageRequest> PayPageRequests { get; set; }
    }

    public class ReportResponse
    {
        public string status { get; set; }
        public string transaction_id { get; set; }
        public string transaction_title { get; set; }
        public string amount { get; set; }
        public string currency { get; set; }
        public string datetime { get; set; }
    }
      





}