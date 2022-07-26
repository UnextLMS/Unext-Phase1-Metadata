select
    distinct c.id as ContactID,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    replace(replace(c.phone, '+', ''), '-', '') as PhoneNumber,
    c.lumen__unContact_Name__c as Name,
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
    q.courseofferingid,
    q.entityId,
    q.choice,
    q.type,
    q.Groupid,
    qm.assignmentLink,
    qm.StartDate,
    qm.Enddate,
    qm.assignmentTitle,
    u.id as UserId,
    concat(c.id, q.entityid) as uniqueid,
    concat(q.entityId, q.uniqueId, c.Id, 'Remainder') as newId,
    'IN' as Locale,
    ce.lumen__unCourse_Name__c as coursename,
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
    inner join lumen__unUser_Group__c_Salesforce as ug on ug.id = q.groupid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join lumen__unUser_Group_Member__c_Salesforce as ugm on ugm.lumen__unGroup__c = ug.id
    inner join contact_Salesforce as c on c.id = ugm.lumen__unContact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    datepart(day, dateadd(day, -1, qm.enddate)) = datepart(day, GETUTCDATE())
    and c.id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.action in ('Published', 'Added')
    and q.groupid is not null
    and q.invalid = 'False'
    and qm.UnPublished = 'False'
    and q.entitytype = 'Assignment'