<%@ WebHandler Language="C#" Class="EventIPNListener" %>

using System;
using System.Collections.Specialized;
using System.Web;

public class EventIPNListener : IHttpHandler 
{
    
    public void ProcessRequest (HttpContext context) 
    {
        System.IO.StreamReader reader = new System.IO.StreamReader(HttpContext.Current.Request.InputStream);
        string responseFromPost = reader.ReadToEnd();

        Helper.PayTabsSession.LastTransactionJson = responseFromPost;

        //Log to File
        Logger.Info("EventIPNListener - Request.Form - Log", "EventIPNListener", responseFromPost);
    }
 
    public bool IsReusable 
    {
        get {return false;}
    }

}