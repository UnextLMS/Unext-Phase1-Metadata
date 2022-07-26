select
    distinct c.Id as contactId,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    c.phone as PhoneNumber,
    c.lumen__unContact_Name__c as Name,
    q.entityLink as assignmentLink,
    q.courseOfferingId,
    q.entityId as assignmentId,
    q.choice,
    q.type,
    q.createdDate,
    qm.startDate,
    qm.endDate,
    qm.assignmentTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as Locale,
    ce.lumen__unCourse_Name__c as courseName,
    u.id as UserId,
    a.name as Program,
    a.parentId as parentId,
    'Report Published' as action,
    'Assignment Report Published' as title,
    concat(
        'Assignment',
        ' ',
        qm.assignmentTitle,
        ' ',
        'report of',
        ce.lumen__unCourse_Name__c,
        ' ',
        'has been published',
        '. '
    ) as Body
from
    [LMS API Event Entry DE] as q
    inner join [Assignment Master Data] as qm on qm.assignmentId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    inner join contact_salesforce as c on c.Id = ce.hed__Contact__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    Target = 'All'
    and q.entityType = 'Assignment'
    and q.query = 'False'
    and u.IsActive = 1
    and q.action = 'Report Published'
    and c.Id IN (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )