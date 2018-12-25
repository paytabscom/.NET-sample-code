<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MakePaymentStep1.aspx.cs" Inherits="TestPTWebService.MakePaymentStep1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <script type="text/javascript">
        // create the back to top button
        $('body').prepend('<a href="#" class="back-to-top">Back to Top</a>');

        // change the value with how many pixels scrolled down the button will appear
        var amountScrolled = 55;

        var CountryZips = {};
        CountryZips['AUS'] = "(0[289][0-9]{2})|([1345689][0-9]{3})|(2[0-8][0-9]{2})|(290[0-9])|(291[0-4])|(7[0-4][0-9]{2})|(7[8-9][0-9]{2})";
        CountryZips['BHR'] = "^([1][0-9]|[0-9])[1-9]{2}$";
        CountryZips['BGD'] = "^[1-9][0-9]{3}$";
        CountryZips['CAN'] = "^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$";
        CountryZips['CHN'] = "^\\d{6}$";
        CountryZips['FRA'] = "^(F-)?((2[A|B])|[0-9]{2})[0-9]{3}$";
        CountryZips['DEU'] = "^[A-Z]{1}( |-)?[1-9]{1}[0-9]{3}$";
        CountryZips['IND'] = "^\\d{6}$";
        CountryZips['ITA'] = "^(V-|I-)?[0-9]{5}$";
        CountryZips['KWT'] = "^\\d{5}$";
        CountryZips['OMN'] = "^\\d{3}$";
        CountryZips['SAU'] = "^\\d{5}(-{1}\\d{4})?$";
        CountryZips['ESP'] = "^\\d{5}$";
        CountryZips['LKA'] = "^\\d{5}$";
        CountryZips['USA'] = "^\d{5}([\-]?\d{4})?$";

        $(window).scroll(function () {
            if ($(window).scrollTop() > amountScrolled) {
                $('a.back-to-top').fadeIn('slow');
            } else {
                $('a.back-to-top').fadeOut('slow');
            }
        });

        $('a.back-to-top, a.simple-back-to-top').click(function () {
            $('html, body').animate({
                scrollTop: 0
            }, 700);
            return false;
        });

        function ValidateZipCode(source, args) {
            var Country = '';
            if (source.id == 'MainContent_cv_ZipCode') {
                Country = document.getElementById('MainContent_ddlCountry');
            }
            else if (source.id == 'MainContent_cv_txtShippingZipCode') {
                Country = document.getElementById('MainContent_ddlShippingCountry');
            }
            var zipRegEx = new RegExp(CountryZips[Country.value]);
            if (!zipRegEx.test(args.Value)) {
                args.IsValid = false;
                source.textContent = 'Invalid Zip Code for ' + Country[Country.selectedIndex].innerText;
                return false;
            }
        }

        function ValidateEmail(source, args) {
            var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
            if (document.getElementById('<%= txtEmailAddress.ClientID %>').value.search(emailRegEx) == -1 && document.getElementById('<%= txtEmailAddress.ClientID %>').value != "") {//          
                args.IsValid = false;
                return false;
            }
            if (document.getElementById('<%= txtEmailAddress.ClientID %>').value == "") {
                args.IsValid = false;
                return false;
            }
        }

        function CopyAddress() {
            if (document.getElementById('<%= chkSameasBillingInfo.ClientID %>').checked) {
                document.getElementById('<%= txtShippingAddress.ClientID %>').value = document.getElementById('<%=  txtAddress1.ClientID %>').value;
                document.getElementById('<%= ddlShippingCountry.ClientID %>').value = document.getElementById('<%=  ddlCountry.ClientID %>').value;
                document.getElementById('<%= txtShippingState.ClientID %>').value = document.getElementById('<%=  txtState.ClientID %>').value;
                document.getElementById('<%= txtShippingCity.ClientID %>').value = document.getElementById('<%=  txtCity.ClientID %>').value;
                document.getElementById('<%= txtShippingZipCode.ClientID %>').value = document.getElementById('<%=  txtZipCode.ClientID %>').value;
                document.getElementById('<%= txtShippingState.ClientID %>').value = document.getElementById('<%=  txtState.ClientID %>').value;
                //document.getElementById('<%= rfv_txtAddress1.ClientID %>').
            }
            else {
                document.getElementById('<%= txtShippingAddress.ClientID %>').value = "";
                document.getElementById('<%= ddlShippingCountry.ClientID %>').selectedIndex = 0;
                document.getElementById('<%= txtShippingState.ClientID %>').value = "";
                document.getElementById('<%= txtShippingCity.ClientID %>').value = "";
                document.getElementById('<%= txtShippingZipCode.ClientID %>').value = "";
                document.getElementById('<%= txtShippingState.ClientID %>').value = "";
            }
        }

        function ValidateData() {

            return true;
        }

        function SetPrice() {

            var amount = Number(document.getElementById('<%= txtQuantity.ClientID %>').value) * Number(document.getElementById('<%= txtPrice.ClientID %>').value);
            document.getElementById('<%= hdnTotalAmount.ClientID %>').value = amount.toFixed(2);
            document.getElementById('<%= lblTotalAmount.ClientID %>').innerHTML = document.getElementById('<%= ddlCurrency.ClientID %>').value + ' - ' + amount.toFixed(2);
        }

        <%--function ValidateWebURL(source, args) {
         var validPass = /[A-Za-z0-9\.-]{3,}\.[A-Za-z]{3}/

         if (document.getElementById('<%= txtWebsite.ClientID %>').value == "") {
            args.IsValid = true;
            return true;
        }
        if (document.getElementById('<%= txtWebsite.ClientID %>').value.search(validPass) == -1) {
         args.IsValid = false;
         return false;
     }
     else {
         args.IsValid = true;
     }
     return false;
 }--%>

    </script>
    <style>
        [data-val-controltovalidate] {
            float: left;
        }
    </style>
    <div id="steps" style="margin-top: 60px;">
        <span class="step1 active">
            <p>
                STEP 1<br />
                Information
            </p>
        </span>
        <span class="step2">
            <p>
                STEP 2
                   <p id="prStep2" style="margin-top: -7px;">Payment</p>
            </p>
        </span>
        <span class="step3">
            <p>
                STEP 3
                   <p id="prStep3" style="margin-top: -7px;">Receipt</p>
            </p>
        </span>
    </div>


    <div class="well" style="margin-top: 115px; width: 95%">

        <div style="height: 900px; margin-top: -20px;">
            <div class="row">
                <div style="width: 540px; float: left;">
                    <fieldset style="margin-top: 20px; margin-left: 15px; width: 95% !important;">
                        <legend class="legend_Frame">Billing Information
                        </legend>
                        <div>
                            <div class="row form-group " style="margin-top: 20px;">
                                <div class="col-md-4">First Name</div>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtFirstName"></asp:TextBox>
                                    <asp:RequiredFieldValidator CssClass="float_left" runat="server" ID="rfv_txtFirstName" ControlToValidate="txtFirstName" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="First Name required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-4">Last Name</div>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtLastName"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtLastName" ControlToValidate="txtLastName" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Last Name required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Email Address</div>
                                <div class="col-md-8">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtEmailAddress"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtEmailAddress" ControlToValidate="txtEmailAddress" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="EmailAddress required"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator runat="server" ID="cv_EmailAddress" ControlToValidate="txtEmailAddress" ClientValidationFunction="ValidateEmail" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Invalid EmailAddress"></asp:CustomValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Phone Number</div>
                                <div class="col-md-6">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtPhone"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtPhone" ControlToValidate="txtPhone" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Phone required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Country</div>
                                <div class="col-md-4">
                                    <asp:DropDownList Height="30" runat="server" CssClass="mandatory form-control" ID="ddlCountry"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_ddlCountry" ControlToValidate="ddlCountry" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="County required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">State</div>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtState"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtState" ControlToValidate="txtState" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="State required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Address 1</div>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtAddress1"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtAddress1" ControlToValidate="txtAddress1" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Address required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">City</div>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtCity"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row form-group " style="margin-top: 20px;">
                                <div class="col-md-4">Zip Code</div>
                                <div class="col-md-6">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtZipCode"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtZipCode" ControlToValidate="txtZipCode" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="ZipCode required"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator runat="server" ID="cv_ZipCode" ControlToValidate="txtZipCode" ClientValidationFunction="ValidateZipCode" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Invalid Zip Code"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>

                <div style="width: 540px; float: right;">
                    <fieldset style="margin-top: 20px; margin-left: 15px; width: 95% !important;">
                        <legend class="legend_Frame">Shipping Information
                        </legend>
                        <div>
                            <div class="row form-group " style="margin-top: 12px;">
                                <div class="col-md-10">
                                    <asp:CheckBox runat="server" ID="chkSameasBillingInfo" Text="Shipping Address same as Billing info" onclick="return CopyAddress();"></asp:CheckBox>
                                </div>
                            </div>
                            <div class="row form-group " style="margin-top: 12px;">
                                <div class="col-md-4">Shipping Address</div>
                                <div class="col-md-6">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtShippingAddress"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtShippingAddress" ControlToValidate="txtShippingAddress" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Shipping Address required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Shipping Country </div>
                                <div class="col-md-6">
                                    <asp:DropDownList Height="30" runat="server" CssClass="mandatory form-control" ID="ddlShippingCountry"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_ddlShippingCountry" ControlToValidate="ddlShippingCountry" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Shipping Country required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Shipping State</div>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtShippingState"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtShippingState" ControlToValidate="txtShippingState" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Shipping State required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Shipping City</div>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtShippingCity"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfv_txtShippingCity" ControlToValidate="txtShippingCity" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Shipping City required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row form-group ">
                                <div class="col-md-4">Shipping Zip Code</div>
                                <div class="col-md-6">
                                    <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtShippingZipCode"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="rfvtxtShippingZipCode" ControlToValidate="txtShippingZipCode" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Shipping ZipCode required"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator runat="server" ID="cv_txtShippingZipCode" ControlToValidate="txtShippingZipCode" ClientValidationFunction="ValidateZipCode" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Invalid ZipCode"></asp:CustomValidator>
                                </div>
                            </div>

                        </div>
                    </fieldset>

                </div>
            </div>
            <div class="row">
                <fieldset style="margin-left: 15px; width: 98% !important;">
                    <legend class="legend_Frame">Product Information
                    </legend>
                    <div>
                        <div class="row form-group " style="margin-top: 20px;">
                            <div class="col-md-2">Product Name</div>
                            <div class="col-md-2">
                                <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtProduct"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtProduct" ControlToValidate="txtProduct" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Product Name required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row form-group ">
                            <div class="col-md-2">Quantity</div>
                            <div class="col-md-2">
                                <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtQuantity" onblur="return SetPrice();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtQuantity" ControlToValidate="txtQuantity" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Quantity required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row form-group ">
                            <div class="col-md-2">Price</div>
                            <div class="col-md-2">
                                <asp:TextBox runat="server" CssClass="mandatory form-control" ID="txtPrice" onblur="return SetPrice();"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_txtPrice" ControlToValidate="txtPrice" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Price required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row form-group ">
                            <div class="col-md-2">Currency</div>
                            <div class="col-md-2">
                                <asp:DropDownList Height="30" runat="server" CssClass="mandatory form-control" ID="ddlCurrency" onchange="return SetPrice();"></asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="rfv_ddlCurrency" ControlToValidate="ddlCurrency" ValidationGroup="CreatePayment" SetFocusOnError="true" ForeColor="Red" ErrorMessage="Currency required"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row form-group ">
                            <div class="col-md-3">
                                <b>Total amount to Pay 
                                    <asp:Label runat="server" ID="lblTotalAmount"></asp:Label>
                                    <asp:HiddenField runat="server" ID="hdnTotalAmount" />
                                </b>
                            </div>
                            <div class="col-md-2">
                            </div>
                        </div>

                    </div>
                </fieldset>
            </div>
            <div class="row">
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label>
            </div>
            <div class="row">
                <div style="margin-left: 10px; margin-right: 45px; float: right">
                    <asp:LinkButton class="btn btn-primary btn-large" ID="btnSave" OnClick="btnSave_click" OnClientClick=" return ValidateData();" SetFocusOnError="true" ValidationGroup="CreatePayment" CausesValidation="True" runat="server">Continue &raquo;</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

