select
    distinct ns.contactId,
    ns.courseOfferingId,
    ns.emailaddress,
    ns.PhoneNumber,
    ns.UserId,
    ns.Program,
    ns.Name,
    ns.CourseName,
    ns.programId,
    ns.parentId,
    concat(ns.contactId, qm.assignmentId) as uniqueId,
    concat(qm.assignmentId, ns.UserId, ns.contactId, 'NewUser') as NewId,
    qm.assignmentLink,
    qm.choice,
    qm.type,
    qm.startDate,
    qm.Enddate,
    qm.assignmentTitle,
    qm.assignmentId,
    'IN' as locale,
    'True' as NewUser,
    'NewUser' as action
from
    [New Students Enrolled] as ns
    inner join [Assignment Master Data] as qm on qm.courseOfferingId = ns.courseOfferingId
where
    ns.query = 'False'
    and qm.unpublished = 'False'
    and ns.groupid = ''