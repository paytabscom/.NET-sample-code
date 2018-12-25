<%@ WebHandler Language="C#" Class="ReportListener" %>

using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Net;
using System.Text;
using System.Web;
using Microsoft.Owin;

public class ReportListener : IHttpHandler 
{
    
    public void ProcessRequest (HttpContext context) 
    {
        System.IO.StreamReader reader = new System.IO.StreamReader(HttpContext.Current.Request.InputStream);
        string requestFromPost = reader.ReadToEnd();

        Helper.PayTabsSession.ReportSearchResult = requestFromPost;
       
        //Log to File
        Logger.Info("ReportListener - Request.Form - Log", "ReportListener", requestFromPost);
    }
 
    public bool IsReusable 
    {
        get {return false;}
    }

}