select
    c.casenumber as CaseNumber,
    con.id as ContactId,
    con.lumen__unContact_Name__c as Name,
    con.email as emailaddress,
    con.phone as phonenumber,
    u.id as userid,
    concat(
        'https://lumen-u-next.force.com/StudentPortal/s/case/',
        c.id,
        '/'
    ) as link
from
    Case_Salesforce as c
    inner join contact_salesforce as con on con.id = c.ContactId
    inner join user_salesforce as u on u.contactid = c.id
where
    (
        datediff(
            day,
            c.lumen__unStatus_Change_Date__c,
            GETUTCDATE()
        ) % 2 = 0
        and lumen__unSub_Status__c = 'Awaiting Student Input'
    )
    and c.contactId is not null