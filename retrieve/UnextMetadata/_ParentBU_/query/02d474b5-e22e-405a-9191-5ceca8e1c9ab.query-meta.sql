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
    q.entityId as assignment,
    qm.assignmentLink,
    qm.choice,
    qm.type,
    qm.startDate,
    qm.endDate,
    qm.assignmentTitle,
    qm.assignmentId,
    'IN' as locale,
    ce.hed__Course_Offering__c as courseOfferingId,
    ce.lumen__unCourse_Name__c as courseName,
    concat(ns.contactId, qm.assignmentId) as uniqueId,
    concat(
        qm.assignmentId,
        ns.GroupId,
        ns.contactId,
        'NewUser'
    ) as NewId,
    'True' as NewUser
from
    [New Students Enrolled] as ns
    inner join [LMS API Event Entry DE] as q on q.groupId = ns.groupId
    inner join [Assignment Master Data] as qm on qm.assignmentId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = qm.courseOfferingId
where
    ns.groupId is not null
    and q.entityType = 'Assignment'
    and qm.unpublished = 'False'
    and ns.query = 'False'