select
    t.name as term,
    pe.hed__Contact__c as ContactId,
    pe.hed__Enrollment_Status__c as Status,
    t.unBatch__c as Batch,
    pr.hed__Sequence__c as Sequence,
    pe.id as ProgramEnrollmentId,
    a.name as Program,
    pr.name as Semester,
    pe.hed__Account__c as programid
from
    HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe
    inner join account_Salesforce as a on a.id = pe.hed__Account__c
    inner join HED__TERM__C_SALESFORCE as t on t.id = pe.Term__c
    inner join HED__PLAN_REQUIREMENT__C_SALESFORCE as pr on pr.id = t.unSemester__c
where
    pe.hed__Enrollment_Status__c in ('Active', 'OnHold')
    and t.unBatch__c is not null