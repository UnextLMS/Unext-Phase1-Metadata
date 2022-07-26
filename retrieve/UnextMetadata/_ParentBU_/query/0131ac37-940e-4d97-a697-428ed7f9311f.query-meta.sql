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
    q.groupId,
    q.createdDate,
    qm.startDate,
    qm.endDate,
    qm.assignmentTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as Locale,
    ce.lumen__unCourse_Name__c as courseName,
    'Report Published' as action,
    'Assignment Report Published' as title,
    concat(
        'Assignment',
        ' ',
        qm.assignmentTitle,
        '''s report of',
        ' ',
        ce.lumen__unCourse_Name__c,
        ' ',
        'has been published',
        '. '
    ) as Body
from
    [LMS API Event Entry DE] as q
    inner join [Assignment Master Data] as qm on qm.assignmentId = q.entityId
    inner join lumen__unUser_Group__c_Salesforce as ug on ug.id = q.groupId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join lumen__unUser_Group_Member__c_Salesforce as ugm on ugm.lumen__unGroup__c = ug.Id
    inner join contact_Salesforce as c on c.Id = ugm.lumen__unContact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    groupId is not null
    and q.query = 'False'
    and entityType = 'Assignment'
    and ug.lumen__unActive__c = 1
    and u.IsActive = 1
    and c.id in (
        select
            hed__contact__c
        from
            HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe
        where
            pe.hed__Enrollment_Status__c = 'Active'
    )
    and q.action = 'Report Published'