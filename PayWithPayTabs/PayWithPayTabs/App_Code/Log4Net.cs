using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using log4net;
using Newtonsoft.Json;


/// <summary>
/// Summary description for Logger
/// </summary>

public static class Logger
{
    private static readonly ILog defaultLogger;

    static Logger()
    {
        defaultLogger = LogManager.GetLogger("PayWithPayTabsServiceCalls");
        log4net.Config.XmlConfigurator.Configure();
    }

    public static void Init()
    {
        // dummy method for static constructor initialization
    }

    #region Info

    public static void Info(string state, string caller, object message)
    {
        try
        {
            string json = JsonConvert.SerializeObject(message);
            defaultLogger.Debug(state +"(" + caller + ")" + string.Format("\t") + string.Format("{0}\n\n", json));
        }
        catch (Exception)
        {
            defaultLogger.Debug(string.Format("{0}\n\n", message));
        }
    }

    #endregion

    #region Error

    public static void Error(object message, Exception exception)
    {
        try
        {
            string json = JsonConvert.SerializeObject(message);
            defaultLogger.Error(json, exception);
        }
        catch (Exception)
        {
            defaultLogger.Error(message, exception);
        }
    }
  
    #endregion
}