select
    a2.lumen__unRecordType_Name__c as ProgramType,
    NewId
from
    [Faculty Live Classroom] as q
    inner join account_salesforce as a on a.parentid = q.parentid
    inner join account_Salesforce as a1 on a1.id = a.parentid
    inner join account_salesforce as a2 on a2.id = a1.parentid