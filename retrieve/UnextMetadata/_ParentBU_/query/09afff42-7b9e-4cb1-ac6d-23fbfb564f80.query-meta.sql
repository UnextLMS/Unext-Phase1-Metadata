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
    q.groupId,
    q.createdDate,
    qm.startDate,
    qm.endDate,
    qm.liveClassroomTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as Locale,
    ce.unext_PE__unCourse_Name__c as courseName
from
    [LMS API Event Entry DE] as q
    inner join [Live Classroom Master Data] as qm on qm.liveClassroomId = q.entityId
    inner join unext_PE__unUser_Group__c_Salesforce as ug on ug.Id = q.groupId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join unext_PE__unUser_Group_Member__c_Salesforce as ugm on ugm.unext_PE__unGroup__c = ug.Id
    inner join contact_Salesforce as c on c.Id = ugm.unext_PE__unContact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    groupId is not null
    and q.query = 'False'
    and q.entitytype = 'Live Classroom'
    and qm.unpublished = 'False'
    and ug.unext_PE__unActive__c = 1
    and u.IsActive = 1
    and c.id in (
        select
            hed__contact__c
        from
            HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe
        where
            pe.hed__Enrollment_Status__c = 'Active'
    )