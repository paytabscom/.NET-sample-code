<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ClientHost.aspx.cs" Inherits="TestPTWebService.ClientHost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <div id="steps" style="margin-top: 60px;" >
        <span class="step1">
            <p>
                STEP 1<br />
                <p id="prStep1" style="margin-top: -7px;">Information</p>
            </p>
        </span>
        <span class="step2 active">
            <p>
                STEP 2
                   Payment
            </p>
        </span>
        <span class="step3">
            <p>
                STEP 3
                   <p id="prStep3" style="margin-top: -7px;">Receipt</p>
            </p>
        </span>
    </div>
    
    <div class="jumbotron" style="margin-top: 120px;">
        <div style="height: 925px; margin-top: -40px;">
            <div class="row">
                <iframe runat="server" ID="iFramePayment" src="#" width="750" height="900"></iframe>
            </div>
            <div class="row">
                <asp:Label runat="server" ID="lblErrorMessage" ForeColor="Red"  ></asp:Label>
            </div>
        </div>

    </div>



</asp:Content>

