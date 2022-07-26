select
    distinct c.Id as contactId,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    c.phone as PhoneNumber,
    c.lumen__unContact_Name__c as Name,
    q.entityLink as quizLink,
    q.courseOfferingId,
    q.entityId as quizId,
    q.choice,
    q.type,
    q.createdDate,
    qm.startDate,
    qm.endDate,
    qm.quizTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as Locale,
    ce.lumen__unCourse_Name__c as courseName,
    a.name as Program,
    u.id as UserId,
    a.parentId as ParentId,
    'Report Published' as action,
    'Quiz Report Published' as title,
    concat(
        'Quiz',
        ' ',
        qm.quizTitle,
        '''s report of',
        ' ',
        ce.lumen__unCourse_Name__c,
        'has been published'
    ) as Body
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Master Data] as qm on qm.quizId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join account_Salesforce as a on a.Id = ce.hed__Account__c
    inner join contact_salesforce as c on c.Id = ce.hed__Contact__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    Target = 'All'
    and q.entityType = 'Quiz'
    and q.Invalid = 'False'
    and u.isactive = 1
    and q.query = 'False'
    and qm.unpublished = 'False'
    and q.action = 'Report Published'
    and c.Id IN (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )