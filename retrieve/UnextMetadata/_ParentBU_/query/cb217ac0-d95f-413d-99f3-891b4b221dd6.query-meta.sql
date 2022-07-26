select
    id as contactid,
    firstname,
    email as emailaddress,
    phone as phonenumber,
    Last_Login_Portal__c as [Last Login to Portal]
from
    contact_Salesforce
where
    Last_Login_Portal__c is null