select
    s.programenrollmentid,
    s.contactid,
    s.Action,
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
    enddate,
    paid
from
    [Semester Term Fee Due Remainder
    and Paid] as s