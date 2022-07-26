select
    distinct ns.contactId,
    ns.courseOfferingId,
    ns.emailAddress,
    ns.phoneNumber,
    ns.Name,
    ns.courseName,
    ns.userId,
    ns.program,
    ns.programId,
    ns.parentId,
    concat(ns.contactId, qm.liveClassroomId) as uniqueId,
    concat(
        qm.liveClassroomId,
        ns.userId,
        ns.contactId,
        'NewUser'
    ) as NewId,
    qm.liveClassroomLink,
    qm.choice,
    qm.type,
    qm.startDate,
    qm.endDate,
    qm.liveClassroomTitle,
    qm.liveClassroomId,
    'IN' as locale,
    'True' as NewUser,
    'NewUser' as action,
    'New Live Classroom Published' as title,
    concat(
        'A new  Live Classroom',
        ' ',
        qm.liveclassroomTitle,
        ' ',
        'has been published in your',
        ' ',
        ns.CourseName,
        ' ',
        'which begins from',
        ' ',
        qm.startdate,
        '.'
    ) as Body
from
    [New Students Enrolled] as ns
    inner join [Live Classroom Master Data] as qm on qm.courseOfferingId = ns.courseOfferingId
where
    ns.query = 'False'
    and qm.unpublished = 'False'
    and ns.groupid = ''