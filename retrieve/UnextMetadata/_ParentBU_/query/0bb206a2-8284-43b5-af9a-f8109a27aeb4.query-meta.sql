select
    t.name,
    t.unEnrollment_Start_Date__c as startdate,
    t.unEnrollment_End_Date__c as enddate,
    t.unBatch__c as batch,
    pr.hed__Sequence__c as sequence,
    t.hed__Account__c as ProgramId,
    pr.name as Semester,
    a.name as ProgramName,
    t.id as term
from
    HED__TERM__C_SALESFORCE as t
    inner join account_Salesforce as a on a.id = t.hed__Account__c
    inner join HED__PLAN_REQUIREMENT__C_SALESFORCE as pr on pr.id = t.unSemester__c
where
    unEnrollment_Start_Date__c is not null
    and unBatch__c is not null