<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="TestPTWebService.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="jumbotron">
        <asp:UpdatePanel runat="server" ID="UpdReports" UpdateMode="Always" RenderMode="Block" >
        <ContentTemplate>
            <div style="width:95%">
            <fieldset style="margin-top: 8px; margin-left: -45px;">
                <legend class="legend_Frame">Report Criteria
                </legend>
                <div class="col-sm-12">
                    <div class="row">
                        &nbsp;
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-6">
                            <div class="col-sm-5 row">
                                <label for="txtReportFromDate" class="form-control-label">Report From Date</label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox runat="server" CssClass="mandatory  form-control" ID="txtReportFromDate"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtReportFromDate" ControlToValidate="txtReportFromDate" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="From Date required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="col-sm-5 row">
                                <label for="txtReportToDate" class="form-control-label">Report To Date</label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox runat="server" CssClass="mandatory  form-control" ID="txtReportToDate"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtReportToDate" ControlToValidate="txtReportToDate" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="To Date required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-12">
                            <asp:LinkButton class="btn btn-primary btn-large pull-right" ID="btnFindReport" OnClick="btnFindReport_click" SetFocusOnError="true" ValidationGroup="CreatePayment" CausesValidation="False" runat="server">Search &raquo;</asp:LinkButton></p>
                        </div>
                    </div>
                    <div class="row">
                        <asp:Label runat="server" ID="lblErrorMessage" ForeColor="Red"  ></asp:Label>
                    </div>
                </div>
            </fieldset>
        
        <div class="row">
            <asp:ListView ID="lvReports" runat="server" ItemPlaceholderID="iph_lvReports">
                <LayoutTemplate>
                    <table class="table table-hover table-bordered ">
                        <tr class="header cell2">
                            <td style="width: 150px">Item</td>
                            <td style="width: 120px">Transaction ID</td>
                            <td style="width: 300px">Currency</td>
                            <td style="width: 120px">Datetime</td>
                            <td style="width: 120px">Status</td>
                        </tr>
                        <tbody id="iph_lvReports" runat="server">
                        </tbody>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr style="text-align: left;">
                        <td style="cursor: pointer; text-align: left;">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse<%# Container.DisplayIndex %>"><%#Eval("transaction_title")%></a>
                            </h4>
                            <div id="collapse<%# Container.DisplayIndex %>" class="panel-collapse collapse">
                                Order Details:
                               
                            </div>
                        </td>
                        <td style="cursor: pointer;"><%#Eval("transaction_id")%></td>
                        <td style="cursor: pointer;"><%#Eval("currency")%><%#Eval("amount")%></td>
                        <td style="cursor: pointer;"><%#Eval("datetime")%></td>
                        <td style="cursor: pointer;"><%#Eval("status")%></td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <table width="100%" border="0" class="table martop" cellspacing="0">
                        <tr class="header">
                            <td colspan="8">
                                <div class="leftb"></div>
                                <span>Today's Payments</span>
                                <div class="rightb"></div>
                            </td>
                        </tr>
                        <tr class="cell2">
                            <td>No Records Found.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>
            </div>

    </ContentTemplate>
            </asp:UpdatePanel>
    </div>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <script>
        $(function () {
            $("#<%= txtReportFromDate.ClientID %>").datepicker(
                {
                    showOtherMonths: true,
                    selectOtherMonths: true,
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    onClose: function (selectedDate) {
                        $("#<%= txtReportToDate.ClientID %>").datepicker("option", "minDate", selectedDate);
                    }
                }
                );
            $("#<%= txtReportToDate.ClientID %>").datepicker(
                  {
                      showOtherMonths: true,
                      selectOtherMonths: true,
                      changeMonth: true,
                      changeYear: true,
                      maxDate: 0
                  }
                );
        });
    </script>
</asp:Content>

