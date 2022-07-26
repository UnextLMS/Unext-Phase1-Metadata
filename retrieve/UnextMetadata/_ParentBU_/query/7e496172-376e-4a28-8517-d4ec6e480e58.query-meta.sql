select
    distinct q.contactId,
    c.email as emailaddress,
    c.phone as PhoneNumber,
    unext_PE__unContact_Name__c as name,
    q.courseOfferingId,
    q.entityId as qaId,
    u.Id as userId,
    concat(c.Id, q.entityId) as uniqueId,
    'New Reply' as action,
    q.entityTitle,
    ce.unext_PE__unCourse_Name__c as courseName,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'New Reply to Your Question' as Title,
    concat(
        q.replierName,
        ' ',
        'has replied to your question in',
        ' ',
        q.entityTitle,
        ' ',
        'of',
        ' ',
        ce.unext_PE__unCourse_Name__c
    ) as Body
from
    [LMS API Event Entry DE] as q
    inner join contact_salesforce as c on c.Id = q.contactId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Contact__c = c.Id
    left join user_Salesforce as u on u.ContactId = c.Id
where
    q.contactId is not null
    and q.entityType = 'Q&A'
    and c.Id IN (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and q.courseOfferingId = ce.hed__Course_Offering__c
    and q.action = 'New Reply'