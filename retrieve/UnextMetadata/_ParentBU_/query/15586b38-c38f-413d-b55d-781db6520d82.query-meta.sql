select
    distinct ns.contactId,
    ns.courseOfferingId,
    ns.emailAddress,
    ns.phoneNumber,
    ns.userId,
    ns.program,
    ns.courseName,
    ns.Name,
    ns.programId,
    ns.parentId,
    concat(ns.contactId, qm.quizId) as uniqueId,
    concat(qm.quizId, ns.userId, ns.contactId, 'NewUser') as newId,
    qm.quizLink,
    qm.choice,
    qm.type,
    qm.startDate,
    qm.endDate,
    qm.quizTitle,
    qm.quizId,
    'IN' as locale,
    'True' as NewUser,
    'New Quiz Published' as Title,
    concat(
        'A new',
        ' ',
        qm.quizTitle,
        ' ',
        'has been published in your',
        ' ',
        ns.courseName,
        ' ',
        'which begins from',
        ' ',
        qm.startDate
    ) as body,
    'NewUser' as action
from
    [New Students Enrolled] as ns
    inner join [Quiz Master Data] as qm on qm.courseOfferingId = ns.courseOfferingId
where
    ns.query = 'False'
    and qm.unpublished = 'False'
    and ns.groupid = ''