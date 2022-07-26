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
    'In' as Locale,
    ce.lumen__unCourse_Name__c as courseName,
    a.name as Program,
    u.id as UserId,
    a.parentId as ParentId,
    'Published' as action,
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
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    inner join contact_salesforce as c on c.Id = ce.hed__Contact__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    Target = 'All'
    and q.entityType = 'Quiz'
    and c.Id IN (
        select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.query = 'False'
    and u.Isactive = 1
    and concat(c.Id, q.entityId) not In (
        select
            uniqueId
        from
            [Quiz Unpublished]
    )
    and q.action IN ('Published', 'Added')