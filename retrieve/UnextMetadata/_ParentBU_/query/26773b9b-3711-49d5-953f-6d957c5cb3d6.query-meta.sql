select
    distinct c.Id as contactId,
    c.email as emailaddress,
    c.phone as PhoneNumber,
    c.unext_PE__unContact_Name__c as name,
    q.entityLink as liveClassroomLink,
    q.courseOfferingId,
    q.entityId as liveClassroomId,
    q.choice,
    q.type,
    q.createdDate,
    qm.startDate,
    qm.endDate,
    qm.liveClassroomTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as Locale,
    ce.unext_PE__unCourse_Name__c as courseName,
    u.id as userId,
    a.name as Program,
    a.parentId as parentId
from
    [LMS API Event Entry DE] as q
    inner join [Live Classroom Master Data] as qm on qm.liveClassroomId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    inner join contact_salesforce as c on c.Id = ce.hed__Contact__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    Target = 'All'
    and q.entityType = 'Live Classroom'
    and q.Invalid = 'False'
    and query = 'False'
    and qm.unpublished = 'False'
    and u.IsActive = 1
    and c.Id IN (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )