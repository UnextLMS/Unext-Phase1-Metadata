select
    distinct c.id as ContactID,
    q.ProgramPlanId,
    c.email as emailaddress,
    c.phone as PhoneNumber,
    c.firstname,
    q.ForumLink,
    q.courseofferingid,
    q.DiscussionForumId,
    q.programenrollmentid as programenrollid,
    u.id as UserId,
    case
        when q.action = 'Published' then 'Published'
        when q.action = 'Edited' then 'Edited'
        when q.action = 'Remainder'
        and datepart(day, dateadd(day, -2, q.newenddate)) = datepart(day, getdate())
        and q.NewEndDate is not null then 'Remainder1'
        when q.action = 'Remainder'
        and datepart(day, dateadd(day, -1, q.newenddate)) = datepart(day, getdate())
        and q.NewEndDate is not null then 'Remainder2'
        when q.action = 'Remainder'
        and datepart(day, q.newenddate) = datepart(day, getdate())
        and q.NewEndDate is not null then 'Remainder3'
        when q.action = 'Remainder'
        and datepart(day, dateadd(day, -2, enddate)) = datepart(day, getdate())
        and q.NewEndDate is null then 'Remainder1'
        when q.action = 'Remainder'
        and datepart(day, dateadd(day, -1, enddate)) = datepart(day, getdate())
        and q.NewEndDate is null then 'Remainder2'
        when q.action = 'Remainder'
        and datepart(day, enddate) = datepart(day, getdate())
        and q.NewEndDate is null then 'Remainder3'
        when q.action = 'Reply' then 'Reply'
        when q.action = 'Upvote' then 'Upvote'
        when q.action = 'Report Published' then 'Report Published'
        when q.action = 'Report Edited' then 'Report Edited'
    end as action,
    case
        when q.action = 'Published' then concat(q.ForumTitle, 'is Published')
        when q.action = 'Edited' then concat(q.ForumTitle, 'is Edited')
    end as Title,
    case
        when q.action = 'Published' then concat('Complete the Forum before', q.enddate)
    end as Body,
    'False' as Attempted,
    'IN' as Locale,
    q.StartDate,
    q.Enddate,
    q.ForumTitle
from
    [Discussion Forum LMS] as q
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.id = q.programenrollmentid
    inner join contact_salesforce as c on c.id = pe.hed__Contact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    Target is null
    and hed__Enrollment_Status__c = 'Active'
    and query = 'False'
    and c.id not in (
        select
            contactid
        from
            [Discussion Forum LMS]
        where
            action = 'Remainder'
            and attempted = 'True'
    )