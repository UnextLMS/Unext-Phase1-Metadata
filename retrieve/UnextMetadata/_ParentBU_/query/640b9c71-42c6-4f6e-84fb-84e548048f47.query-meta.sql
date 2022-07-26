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
    q.entityid as quiz,
    qm.quizLink,
    qm.choice,
    qm.type,
    qm.startDate,
    qm.endDate,
    qm.quizTitle,
    qm.quizId,
    'IN' as locale,
    ce.hed__Course_Offering__c as courseOfferingId,
    ce.lumen__unCourse_Name__c as courseName,
    concat(ns.contactId, qm.quizId) as uniqueId,
    concat(qm.quizId, ns.groupId, ns.contactId, 'NewUser') as NewId,
    'True' as NewUser,
    'New Quiz Published' as Title,
    concat(
        'A new',
        ' ',
        qm.quizTitle,
        ' ',
        'has been published in your',
        ' ',
        ce.lumen__unCourse_Name__c,
        ' ',
        'which begins from',
        ' ',
        qm.startDate
    ) as body
from
    [New Students Enrolled] as ns
    inner join [LMS API Event Entry DE] as q on q.groupId = ns.groupId
    inner join [Quiz Master Data] as qm on qm.quizId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = qm.courseOfferingId
where
    ns.groupId is not null
    and q.entityType = 'Quiz'
    and qm.unpublished = 'False'
    and ns.query = 'False'