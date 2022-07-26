select
    s.programenrollmentid,
    s.contactid,
    'True' as Paid,
    CurrentTerm,
    batch,
    sequence,
    Status,
    emailaddress,
    PhoneNumber,
    systemtoken,
    deviceid,
    platform,
    Program,
    Semester,
    NewTerm,
    Sent,
    NewTermId,
    startdate,
    enddate
from
    [Semester Term Fee Due Sendable] as s
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.id = s.programenrollmentid
    inner join hed__Term__c_Salesforce as t on t.id = pe.Term__c
where
    pe.Term__c = t.id