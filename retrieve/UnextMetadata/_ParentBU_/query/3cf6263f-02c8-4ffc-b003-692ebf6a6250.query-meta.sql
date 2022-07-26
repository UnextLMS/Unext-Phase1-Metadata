select
    distinct c.id as ContactID,
    c.email as emailaddress,
    c.phone as PhoneNumber,
    c.unext_PE__unContact_Name__c as name,
    q.courseofferingid,
    q.entityId,
    q.choice,
    q.type,
    qm.startDate,
    qm.Enddate,
    u.id as UserId,
    concat(c.id, q.entityid) as uniqueid,
    concat(q.entityid, q.uniqueid, c.id, 'Remainder') as newid,
    'IN' as Locale,
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
        ce.unext_PE__unCourse_Name__c,
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
    ) as body,
    case
        when Len(qm.assignmentTitle) < 30 then qm.assignmentTitle
        else concat(Substring(qm.assignmentTitle, 1, 28), '..')
    end as assignmentTitle,
    case
        when Len(ce.unext_PE__unCourse_Name__c) < 30 then ce.unext_PE__unCourse_Name__c
        else concat(
            Substring(ce.unext_PE__unCourse_Name__c, 1, 28),
            '..'
        )
    end as coursename,
    case
        when Len(qm.assignmentLink) < 30 then qm.assignmentLink
        else concat(Substring(qm.assignmentLink, 1, 28), '..')
    end as assignmentLink
from
    [LMS API Event Entry DE] as q
    inner join [Assignment Master Data] as qm on qm.assignmentId = q.entityid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join contact_salesforce as c on c.id = ce.hed__Contact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    q.Target = 'All'
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
    and q.entitytype = 'Assignment'