create table Payment
(
PaymentId int identity(1,1),
currency varchar(25),
amount varchar(25),
site_url varchar(25),
title varchar(40),
quantity varchar(25),
unit_price varchar(25),
products_per_title varchar(50),
return_url varchar(25),
cc_first_name varchar(40),
cc_last_name varchar(40),
cc_phone_number varchar(25),
phone_number varchar(25),
billing_address varchar(25),
city varchar(25),
state varchar(25),
postal_code varchar(25),
country varchar(25),
email varchar(25),
ip_customer varchar(25),
ip_merchant varchar(25),
address_shipping varchar(50),
city_shipping varchar(25),
state_shipping varchar(25),
postal_code_shipping varchar(25),
country_shipping varchar(25),
other_charges varchar(25),
discount varchar(25),
reference_no varchar(25),
msg_lang varchar(25),
cms_with_version varchar(25),
Status varchar(25),
TransactionTime varchar(25),
ErrorMessage varchar(50)

)


create table ReportRequest
(
ReportRequestID int identity(1,1),
result  varchar(25),
response_code  varchar(25),
error_code  varchar(25),
pt_invoice_id  varchar(25),
amount  varchar(25),
currency  varchar(25),
reference_no  varchar(25),
transaction_id  varchar(25),
shipping_address  varchar(25),
shipping_city  varchar(25),
shipping_country  varchar(25),
shipping_state  varchar(25),
shipping_postalcode  varchar(25),
phone_num  varchar(25),
customer_name  varchar(25),
email  varchar(25),
detail  varchar(25),
reference_id  varchar(25),
invoice_id  varchar(25)

)