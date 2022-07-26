select
    distinct c.Id as contactId,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    c.phone as phoneNumber,
    c.lumen__unContact_Name__c as Name,
    q.courseOfferingId,
    q.entityId as quizId,
    q.choice,
    q.type,
    q.createdDate,
    qm.quizLink,
    qm.startDate,
    qm.endDate,
    qm.quizTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as locale,
    a.name as Program,
    a.parentId as ParentId,
    ce.lumen__unCourse_Name__c as courseName,
    u.Id as userId,
    'Published' as action,
    'New Quiz Published' as title,
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
    ) as body,
    case
        when q.action = 'Published' then 'Send'
        when q.action = 'Added'
        and qm.unpublished = 'False' then 'Send'
        when q.action = 'Added'
        and qm.unpublished = 'True' then 'Dont Send'
    end as Journeyaction
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Master Data] as qm on qm.quizId = q.entityId
    inner join contact_salesforce as c on c.Id = q.contactId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Contact__c = c.Id
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    q.contactId is not null
    and q.entityType = 'Quiz'
    and c.Id IN (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.query = 'False'
    and u.IsActive = 1
    and q.courseOfferingid = ce.hed__Course_Offering__c
    and q.action IN ('Published', 'Added')
    and concat(c.Id, q.entityId) not IN (
        select
            uniqueId
        from
            [Quiz Unpublished]
    )