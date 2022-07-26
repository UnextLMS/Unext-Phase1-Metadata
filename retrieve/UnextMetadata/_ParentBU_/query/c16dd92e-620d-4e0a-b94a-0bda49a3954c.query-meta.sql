select
    distinct c.Id as contactId,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    c.phone as phoneAddress,
    c.lumen__unContact_Name__c as Name,
    q.courseOfferingId,
    q.entityId as quizId,
    q.choice,
    q.type,
    q.groupId,
    q.createdDate,
    qm.quizLink,
    qm.startDate,
    qm.endDate,
    qm.quizTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as locale,
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
    inner join lumen__unUser_Group__c_Salesforce as ug on ug.Id = q.groupId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join lumen__unUser_Group_Member__c_Salesforce as ugm on ugm.lumen__unGroup__c = ug.id
    inner join contact_Salesforce as c on c.id = ugm.lumen__unContact__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    q.groupId is not null
    and q.entityType = 'Quiz'
    and c.Id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.query = 'False'
    and ug.lumen__unActive__c = 1
    and u.IsActive = 1
    and q.action IN('Published', 'Added')
    and concat(c.Id, q.entityId) not IN (
        select
            uniqueId
        from
            [Quiz Unpublished]
    )