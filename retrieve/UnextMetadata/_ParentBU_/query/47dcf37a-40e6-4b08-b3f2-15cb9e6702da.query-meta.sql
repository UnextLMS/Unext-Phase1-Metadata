select
    a.id as [Announcement Id],
    unPrograms_Selected__c as Program,
    unTitle__c as [Announcement Title],
    unBody__c as [Announcement Body],
    c.email as [Email],
    c.phone as [MobileNo],
    c.firstname as [FirstName],
    c.id as [Contact Id]
from
    un_Announcement__c_Salesforce as a
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.hed__Account__c = a.unPrograms__c
    inner join contact_Salesforce as c on c.id = pe.hed__Contact__c
where
    hed__Enrollment_Status__c = 'Active'