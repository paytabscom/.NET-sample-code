<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="TestPTWebService.Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">Do you have an account with PayTabs ?</p>
        <div class="row">
            <div class="col-md-1">
                <p><a href="ClientSettings.aspx" class="btn btn-primary btn-large">Yes &raquo;</a></p>
            </div>
            <div class="col-md-1">
                <p><a href="https://www.paytabs.com/sign_up" class="btn btn-primary btn-large">No &raquo;</a></p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4">
       
        </div>
        <div class="col-md-4">
            
        </div>
        
    </div>
</asp:Content>
