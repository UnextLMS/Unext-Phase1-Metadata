select
    distinct q.contactId,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    replace(replace(c.phone, '+', ''), '-', '') as PhoneNumber,
    c.lumen__unContact_Name__c as name,
    case
        when len(lumen__unContact_Name__c) <= 30 then c.lumen__unContact_Name__c
        else concat(substring(c.lumen__unContact_Name__c, 1, 27), '...')
    end as smsname,
    case
        when len(qm.assignmentTitle) <= 30 then qm.assignmentTitle
        else concat(substring(qm.assignmentTitle, 1, 27), '...')
    end as smsassignmentTitle,
    case
        when len(ce.lumen__unCourse_Name__c) <= 30 then ce.lumen__unCourse_Name__c
        else concat(substring(ce.lumen__unCourse_Name__c, 1, 27), '...')
    end as smscoursename,
    q.courseOfferingId,
    q.entityId,
    q.choice,
    q.type,
    u.Id as UserId,
    qm.assignmentLink,
    qm.startDate,
    qm.enddate,
    qm.assignmentTitle,
    qm.assignmentId,
    concat(c.Id, q.entityId) as uniqueId,
    concat(q.entityId, q.uniqueId, c.Id, 'Remainder') as newId,
    'IN' as Locale,
    ce.lumen__unCourse_Name__c as courseName,
    a.name as Program,
    a.parentid,
    'Remainder' as action,
    'Assignment Remainder' as title,
    concat(
        'Only 1 day left for Assignment',
        ' ',
        qm.assignmentTitle,
        ' ',
        ' ',
        'submission of',
        ' ',
        ce.lumen__unCourse_Name__c,
        ' ',
        'as deadline is',
        ' ',
        qm.endDate,
        '.',
        ' ',
        'Please submit it before the',
        ' ',
        qm.endDate,
        '.'
    ) as body
from
    [LMS API Event Entry DE] as q
    inner join [Assignment Master Data] as qm on qm.assignmentId = q.entityid
    inner join contact_salesforce as c on c.id = q.contactId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Contact__c = c.id
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    q.contactid is not null
    and q.entitytype = 'Assignment'
    and q.invalid = 'False'
    and qm.UnPublished = 'False'
    and u.IsActive = 1
    and c.id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.action in ('Published', 'Added')
    and datepart(day, dateadd(day, -1, qm.enddate)) = datepart(day, GETUTCDATE())
    and q.courseofferingid = ce.hed__Course_Offering__c