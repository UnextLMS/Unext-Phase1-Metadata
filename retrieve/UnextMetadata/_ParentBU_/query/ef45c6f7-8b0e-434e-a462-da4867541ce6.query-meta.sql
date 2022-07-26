select
    distinct ns.contactId,
    ns.emailAddress,
    ns.phoneNumber,
    ns.userId,
    ns.Name,
    ns.groupId,
    ns.Program,
    ns.programId,
    ns.parentId,
    q.action,
    q.groupId as lmsgroup,
    q.entityid as liveClassroom,
    qm.liveClassroomLink,
    qm.choice,
    qm.type,
    qm.startDate,
    qm.endDate,
    qm.liveClassroomTitle,
    qm.liveClassroomId,
    'IN' as locale,
    ce.hed__Course_Offering__c as courseOfferingId,
    ce.lumen__unCourse_Name__c as courseName,
    concat(ns.contactId, qm.liveClassroomId) as uniqueId,
    concat(
        qm.liveClassroomId,
        ns.groupId,
        ns.contactId,
        'NewUser'
    ) as NewId,
    'New Live Classroom Published' as title,
    concat(
        'A new  Live Classroom',
        ' ',
        qm.liveclassroomTitle,
        ' ',
        'has been published in your',
        ' ',
        ce.lumen__unCourse_Name__c,
        ' ',
        'which begins from',
        ' ',
        qm.startdate,
        '.'
    ) as Body,
    'True' as NewUser
from
    [New Students Enrolled] as ns
    inner join [LMS API Event Entry DE] as q on q.groupId = ns.groupId
    inner join [Live Classroom Master Data] as qm on qm.liveClassroomId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = qm.courseOfferingId
where
    ns.groupId is not null
    and q.entityType = 'Live Classroom'
    and qm.unpublished = 'False'
    and ns.query = 'False'