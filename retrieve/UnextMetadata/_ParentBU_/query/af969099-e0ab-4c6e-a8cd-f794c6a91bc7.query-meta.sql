select
    newid,
    a.name as Program,
    a.ParentId as ParentId
from
    [Discussion Forum Sendable] as dfs
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = dfs.courseofferingid
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.id = ce.hed__Program_Enrollment__c
    inner join account_salesforce as a on a.id = pe.hed__account__c
where
    dfs.groupid is not null
    and program is null