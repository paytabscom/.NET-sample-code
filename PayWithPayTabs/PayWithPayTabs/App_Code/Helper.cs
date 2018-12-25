using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Helper
/// </summary>
public class Helper : System.Web.UI.Page
{
	public static class PayTabsSession
    {
        public static string Name { get; set; }
        public static string SecretKey { get; set; }
        public static bool InvalidSecretKey { get; set; }
        public static string EmailAddress { get; set; }
        public static string Password { get; set; }
        public static string SiteUrl { get; set; }
        public static string LastPaymentReferenceNumber { get; set; }
        public static string CurrentActivePaymentID { get; set; }
        public static List<Models.PayPageRequest> PageRequestList { get; set; }
        public static string ReportSearchResult { get; set; }
        public static string LastTransactionJson { get; set; }
    }

    public static void SetSession(string ss)
    {
        PayTabsSession.ReportSearchResult = ss;
    }
}