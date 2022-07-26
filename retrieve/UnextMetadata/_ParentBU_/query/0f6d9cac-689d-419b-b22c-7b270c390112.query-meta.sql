select
    s2.programenrollmentid,
    s2.contactid,
    s2.batch,
    s2.sequence,
    s2.Term as currentterm,
    c.email as emailaddress,
    c.firstname,
    c.phone as Phonenumber,
    s2.programname,
    s1.semester,
    s1.name as NewTerm,
    s2.status,
    s1.term as newtermid
from
    [Semester Fee Due2] as s2
    inner join [Semester Term Fee Due1] as s1 on s1.programid = s2.programid
    inner join contact_Salesforce as c on c.id = s2.contactid
where
    s2.sequence = s1.sequence -1
    and s2.status = 'OnHold'