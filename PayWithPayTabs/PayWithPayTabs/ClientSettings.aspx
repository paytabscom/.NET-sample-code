<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ClientSettings.aspx.cs" Inherits="TestPTWebService.ClientSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="well" style="margin-top: 30px; height: 450px; width: 95%;">

        <fieldset style="margin-top: 20px; margin-left: 15px; width: 95% !important;">
            <legend class="legend_Frame"> Client Settings
            </legend>
            <div class="row">
                &nbsp;
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">Client Name</label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtClientName" CssClass="input-lg form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtClientName" ControlToValidate="txtClientName" ValidationGroup="CientInfo" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Client Name required"></asp:RequiredFieldValidator>

                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label">Secret Key</label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtSecretKey" CssClass="input-lg form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtSecretKey" ControlToValidate="txtSecretKey" ValidationGroup="CientInfo" SetFocusOnError="true" ForeColor="Red" ErrorMessage="SecretKey required"></asp:RequiredFieldValidator>
                </div>
            </div>


            <div class="form-group">
                <label class="col-md-2 control-label">Email Address</label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtEmailAddress" CssClass="input-lg form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtEmailAddress" ControlToValidate="txtEmailAddress" ValidationGroup="CientInfo" SetFocusOnError="true" ForeColor="Red" ErrorMessage="EmailAddress required"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label">Password</label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtPassword" CssClass="input-lg form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtPassword" ControlToValidate="txtPassword" ValidationGroup="CientInfo" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Password required"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-2 control-label">WebSite URL</label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ReadOnly ID="txtWebSite" CssClass="input-lg form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtWebSite" ControlToValidate="txtWebSite" ValidationGroup="CientInfo" SetFocusOnError="true" ForeColor="Red" ErrorMessage="WebSite required"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group pull-right">
                <asp:LinkButton class="btn btn-primary btn-large" ID="btnSave" OnClick="btnSave_click" runat="server" ValidationGroup="CientInfo" Visible="False">Save &raquo;</asp:LinkButton>
                <asp:LinkButton class="btn btn-primary btn-large" ID="btnValidateKey" OnClick="btnValidateKey_click" runat="server" ValidationGroup="CientInfo">Validate Secret Key</asp:LinkButton>
            </div>

            <div class="row">
                <asp:Label runat="server" ID="lblErrorMessage" ForeColor="Red"></asp:Label>
            </div>
        </fieldset>
    </div>
</asp:Content>

