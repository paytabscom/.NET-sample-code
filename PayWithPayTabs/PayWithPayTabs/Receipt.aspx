<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receipt.aspx.cs" Inherits="TestPTWebService.Receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="steps" style="margin-top: 60px;">
        <span class="step1 ">
            <p>
                STEP 1<br />
                <p id="prStep1" style="margin-top: -7px;">Information</p>
            </p>
        </span>
        <span class="step2">
            <p>
                STEP 2
                   <p id="prStep2" style="margin-top: -7px;">Payment</p>
            </p>
        </span>
        <span class="step3 active">
            <p>
                STEP 3<br />
                <p>Receipt</p>
            </p>
        </span>
    </div>
    <style>
        #page-wrap { width: 800px; margin: 0 auto;float: left;}

table { border-collapse: collapse; }
table td, table th { border: 1px solid #d9e7f4; padding: 3px; }

#header { height: 35px; width: 100%; margin: 20px 0; background: #d9e7f4; text-align: center; color: black; font: bold 15px Helvetica, Sans-Serif; text-decoration: uppercase; letter-spacing: 20px; padding: 8px 0px; }

#address { width: 250px; height: 150px; float: left; }
#customer { overflow: hidden; }

#logo { text-align: right; float: right; position: relative; margin-top: 25px; border: 1px solid #fff; max-width: 540px; max-height: 100px; overflow: hidden; }
#logoctr { display: none; }
#logohelp { text-align: left; display: none; font-style: italic; padding: 10px 5px;}
#logohelp input { margin-bottom: 5px; }
.edit #logohelp { display: block; }
.edit #save-logo, .edit #cancel-logo { display: inline; }
.edit #image, #save-logo, #cancel-logo, .edit #change-logo, .edit #delete-logo { display: none; }
#customer-title { font-size: 12px; font-weight: bold; float: left; }

#meta { margin-top: 1px; width: 300px; float: right; }
#meta td { text-align: right;  }
#meta td.meta-head { text-align: left; background: #d9e7f4; }
#meta td textarea { width: 100%; height: 20px; text-align: right; }

#items { clear: both; width: 100%; margin: 30px 0 0 0; border: 1px solid #d9e7f4; }
#items th { background: #d9e7f4; }
#items textarea { width: 80px; height: 50px; }
#items tr.item-row td { border: 0; vertical-align: top;border-right: 1px solid #d9e7f4; border-bottom: 1px solid #d9e7f4;}
#items td.description { width: 300px; }
#items td.item-name { width: 175px; }
#items td.description textarea, #items td.item-name textarea { width: 100%; }
#items td.total-line { border-right: 0; text-align: right; }
#items td.total-value { border-left: 0; padding: 10px; }
#items td.total-value textarea { height: 20px; background: none; }
#items td.balance { background: #d9e7f4; }
#items td.blank { border: 0; }

#terms { text-align: left; margin: 20px 0 0 0; }
#terms h5 { text-transform: uppercase; font: 13px Helvetica, Sans-Serif; letter-spacing: 10px; border-bottom: 1px solid #d9e7f4; padding: 0 0 8px 0; margin: 0 0 8px 0; }
    </style>
    <div  style="margin-top: 120px;">
        <div style="height: 925px; margin-top: -40px;">
            <div class="row">
                <asp:Label runat="server" ID="lblErrorMessage" ForeColor="Red"></asp:Label>
            </div>

              <div id="page-wrap">
		<div id="header">INVOICE</div>
		<div id="identity">
		
		    <div id="address">
                <strong>PayTabs</strong><br />
                Business Bay Building,No. 1260, Road No. 2421, <br />
                Juffair, Al Fateh<br />
                Kingdom of Bahrain
		    </div>

            <div id="logo">
              <div id="logohelp">
              </div>
                <img id="image" src="Content/Images/demo.jpg" alt="logo" style="width: 130px;"><br>
                <img id="image1" src="Content/Images/sucesspayment.png" alt="apilogo">
            </div>
		
		</div>
		<div style="clear:both"></div>
		<div id="customer">
            <div id="customer-title">
                <b>Purchaser Name:</b>
                <strong>
                    <asp:Label runat="server" ID="lblName"></asp:Label>
                </strong><br /><br />
                <b>Card Type:</b><asp:Label runat="server" ID="lblCardType"></asp:Label><div style="margin-top: -24px;margin-left: 80px;"><img id="cardType" src="Content/Images/visa.png" alt="card" runat="server"/></div><br />
               <%-- <i>Billing:</i><asp:Label runat="server" ID="lblBillingaddress"></asp:Label><br />--%>
                <i>Shipping Address: </i> <br /><asp:Label runat="server" ID="lblShippingAddress"></asp:Label> <br />
                <b>Phone :</b> <asp:Label runat="server" ID="lblPhone"></asp:Label><br />
                <b>E-mail :</b> <asp:Label runat="server" ID="lblEmail"></asp:Label>
            </div>
            <table id="meta">
                <tbody><tr>
                    <td class="meta-head">Invoice #</td>
                    <td><asp:Label runat="server" ID="lblInvoiceNo"></asp:Label></td>
                </tr>
                <tr>
                    <td class="meta-head">Date</td>
                    <td><asp:Label runat="server" ID="lblTransactionDate"></asp:Label></td>
                </tr>
                <tr>
                    <td class="meta-head">Amount Due</td>
                    <td><asp:Label runat="server" ID="lblAmountDue"></asp:Label></td>
                </tr>
            </tbody></table>
		</div>
		<table id="items">
		  <tbody><tr>
		    <th style="width:50px;">S.No</th>
            <th>Description</th>
            <th style ="width:85px;">Unit Cost</th>
            <th style ="width:70px;">Quantity</th>
            <th style="width:90px;">Price</th>
		  </tr>
		  <tr class="item-row">
		      <td class="item-name"> 1 </td>
		      <td class="description"><asp:Label runat="server" ID="lblProduct"></asp:Label></td>
		      <td><div class="cost"><asp:Label runat="server" ID="lblCost"></asp:Label></div></td>
		      <td><div class="qty"><asp:Label runat="server" ID="lblQuantity"></asp:Label></div></td>
		      <td><span class="price"><asp:Label runat="server" ID="lblAmount"></asp:Label></span></td>
		  </tr>  
		  <tr>
		      <td colspan="2" class="blank"> </td>
		      <td colspan="2" class="total-line">Total</td>
		      <td class="total-value"><div id="total"><asp:Label runat="server" ID="lblTotalAmount"></asp:Label></div></td>
		  </tr>
	
		</tbody></table>
		<div id="terms">
            <strong>Important: </strong>
		    <ol>
		        <ul>
		            This is an electronic generated invoice so doesn't require any signature.
		        </ul>
		        <ul>
		           &nbsp;
		        </ul>
		    </ol>
		    Message : <img id="imgMessage" src=".." alt="logo" style="width:24px;height: 24px;" runat="server"/> <asp:Label runat="server" ID="lblMessage"></asp:Label>
		</div>
	</div>
            

            
        </div>

    </div>
</asp:Content>


      
