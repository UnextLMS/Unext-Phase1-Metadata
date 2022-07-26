select
    case
        when a1.unRecordType_Name__c = 'Unext Offering' then a1.unRecordType_Name__c
        else a2.unRecordType_Name__c
    end as ProgramType,
    NewId
from
    [Discussion Forum Sendable] as q
    inner join account_salesforce as a on a.parentid = q.parentid
    inner join account_Salesforce as a1 on a1.id = a.parentid
    inner join account_salesforce as a2 on a2.id = a1.parentid
where
    q.action = 'Remainder'