<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PaymentsDoneToday.aspx.cs" Inherits="PaymentsDoneToday" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <div class="jumbotron">
        <div style="margin-left: -45px;">
        <asp:ListView ID="lvPaymentsToday" runat="server" ItemPlaceholderID="iph_lvPaymentsToday" >
                    <LayoutTemplate>
                        <table width="100%" border="0" class="table martop" cellspacing="0" >
                            <tr class="header">
                                <td colspan="8"><div class="leftb" > </div><span>Today's Payments</span><div class="rightb" > </div></td>
                            </tr>
                            <tr class="subheader">
                                <td style="width: 150px">Name</td>
                                <td style="width: 120px">Email</td>
                                <td style="width: 300px">Shipping Address</td>
                                <td style="width: 120px">Amount</td>
                            </tr>
                            <tbody id="iph_lvPaymentsToday" runat="server">
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr class="<%# Container.DisplayIndex % 2 == 0 ? "cell2" : "cell1" %> " style="text-align:right;">
                            <td style="cursor:pointer;text-align:left;" ><%#Eval("Name")%></td>
                            <td style="cursor:pointer;" ><%#Eval("Email")%></td>
                            <td style="cursor:pointer;" ><%#Eval("AddressShipping")%></td>
                            <td style="cursor:pointer;"><%#Eval("Amount")%></td>
                            <td style="cursor:pointer;text-align:left;display: none"><asp:Label ID="lblStatus" runat="server" Text='<%#Eval("Amount")%>'></asp:Label></td>
                        </tr>                        
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <table width="100%" border="0" class="table martop" cellspacing="0" >
                             <tr class="header">
                                <td colspan="8">
                                    <div class="leftb" > </div>
                                        <span>Today's Payments</span>
                                     <div class="rightb" > </div>
                                </td>
                            </tr>
                            <tr class="subheader">
                                <td style="width: 150px">Name</td>
                                <td style="width: 120px">Email</td>
                                <td style="width: 300px">Shipping Address</td>
                                <td style="width: 120px">Amount</td>
                            </tr>
                            <tr class="cell2">
                                <td>No Records Found.</td>
                            </tr>
                         </table> 
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
    </div>
</asp:Content>

