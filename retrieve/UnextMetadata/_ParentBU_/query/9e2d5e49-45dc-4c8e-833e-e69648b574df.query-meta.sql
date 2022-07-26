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
    q.groupId,
    q.createdDate,
    qm.startDate,
    qm.endDate,
    qm.quizTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as Locale,
    ce.lumen__unCourse_Name__c as courseName,
    'Report Published' as action,
    'Quiz Report Published' as Title,
    concat(
        'Quiz',
        ' ',
        qm.quizTitle,
        '''s report of',
        ' ',
        ce.lumen__unCourse_Name__c,
        'has been published'
    ) as body
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Master Data] as qm on qm.quizId = q.entityId
    inner join lumen__unUser_Group__c_Salesforce as ug on ug.id = q.groupId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join lumen__unUser_Group_Member__c_Salesforce as ugm on ugm.lumen__unGroup__c = ug.Id
    inner join contact_Salesforce as c on c.Id = ugm.lumen__unContact__c
    left join user_Salesforce as u on u.contactId = c.id
where
    q.groupId is not null
    and q.Invalid = 'False'
    and q.query = 'False'
    and q.entityType = 'Quiz'
    and ug.lumen__unActive__c = 1
    and u.IsActive = 1
    and qm.unpublished = 'False'
    and c.id in (
        select
            hed__contact__c
        from
            HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe
        where
            pe.hed__Enrollment_Status__c = 'Active'
    )
    and q.action = 'Report Published'