<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RefundPayment.aspx.cs" Inherits="RefundPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="jumbotron">
        <div style="height: 320px;margin-left: -40px;">
            <div style="margin-top: 8px;width: 95% !important;">
                <fieldset >
                    <legend class="legend_Frame">Refund Information
                    </legend>
                    <div class="col-sm-12">
                        <div class="row">
                            &nbsp;
                        </div>
                        <div class="form-group row">
                            <label for="txtPageId" class="col-sm-3 form-control-label">Page ID</label>
                            <div class="col-sm-9">
                                <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtPageId"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtPageId" ControlToValidate="txtPageId" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Refund PageId required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtRefundAmount" class="col-sm-3 form-control-label">Refund Amount</label>
                            <div class="col-sm-9">
                                <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtRefundAmount"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtRefundAmount" ControlToValidate="txtRefundAmount" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Refund Amount required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtRefundReason" class="col-sm-3 form-control-label">Refund Reason</label>
                            <div class="col-sm-9">
                                <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtRefundReason"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtRefundReason" ControlToValidate="txtRefundReason" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Refund Reason required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row">
                            <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="form-group row pull-right">
                            <div class="col-sm-12">
                                <asp:LinkButton class="btn btn-primary btn-large right" ID="btnDoRefund" OnClick="btnDoRefund_click" SetFocusOnError="true" ValidationGroup="CreatePayment" CausesValidation="True" runat="server">Do Refund &raquo;</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

</asp:Content>

