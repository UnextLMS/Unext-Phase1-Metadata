select
    newid,
    a.name as Program,
    a.ParentId as ParentId
from
    [Faculty Assignment] as qs
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = qs.courseOfferingId
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.id = ce.hed__Program_Enrollment__c
    inner join account_salesforce as a on a.id = pe.hed__account__c
where
    qs.program is null