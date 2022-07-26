select
    distinct c.Id as contactId,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    c.phone as PhoneNumber,
    lumen__unContact_Name__c as name,
    q.courseOfferingId,
    q.entityId as liveClassroomId,
    q.choice,
    q.type,
    q.createdDate,
    qm.liveClassroomLink,
    qm.startDate,
    qm.endDate,
    qm.liveClassroomTitle,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, q.action) as newId,
    'IN' as Locale,
    ce.lumen__unCourse_Name__c as CourseName,
    u.id as userId,
    a.name as Program,
    'Published' as action,
    'New Live Classroom Published' as title,
    concat(
        'A new  Live Classroom',
        ' ',
        qm.liveClassroomTitle,
        ' ',
        'has been published in your',
        ' ',
        ce.lumen__unCourse_Name__c,
        ' ',
        'which begins from',
        ' ',
        qm.startDate,
        '.'
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
    inner join [Live Classroom Master Data] as qm on qm.liveClassroomId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    inner join contact_salesforce as c on c.Id = ce.hed__Contact__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    Target = 'All'
    and q.entityType = 'Live Classroom'
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
    and concat(c.Id, q.entityId) not IN (
        select
            uniqueId
        from
            [Live Classroom Unpublished]
    )
    and q.action in ('Published', 'Added')