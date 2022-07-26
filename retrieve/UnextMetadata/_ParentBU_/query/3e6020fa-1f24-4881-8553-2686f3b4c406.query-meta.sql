select
    distinct c.id as ContactId,
    dateadd(hour, 10, dateadd(minute, 30, dfm.startdate)) as EventSD,
    case
        when datediff(day, dfm.startdate, dfm.enddate) = 1
        or datediff(day, dfm.startdate, dfm.enddate) = 0 then dfm.startdate
        else dateadd(day, 1, dfm.startdate)
    end as AllDayEventSD,
    case
        when datediff(day, dfm.startdate, dfm.enddate) = 1
        or datediff(day, dfm.startdate, dfm.enddate) = 0 then dfm.enddate
        else dateadd(day, -1, dfm.enddate)
    end as AllDayEventED,
    dateadd(hour, 10, dateadd(minute, 30, dfm.enddate)) as EventED,
    dateadd(
        second,
        -1,
        dateadd(
            day,
            1,
            dateadd(
                day,
                0 + datediff(day, '19000101', dfm.StartDate),
                '19000101'
            )
        )
    ) as EventNSD,
    case
        when datepart(month, dfm.enddate) = 5 then dateadd(
            second,
            -1,
            dateadd(
                day,
                1,
                dateadd(
                    day,
                    1 + datediff(day, '19000101', dfm.endDate),
                    '19000101'
                )
            )
        )
        else dateadd(
            second,
            -1,
            dateadd(
                day,
                1,
                dateadd(
                    day,
                    0 + datediff(day, '19000101', dfm.endDate),
                    '19000101'
                )
            )
        )
    end as EventNED,
    case
        when q.action = 'Invalid' then 'EventDeletion'
        when q.action = 'Published'
        OR q.action = 'Added' then 'EventPublished'
    end as Action,
    case
        when action = 'Published' then 'Send'
        when action in ('Added', 'Invalid')
        and dfm.unpublished = 'False' then 'Send'
        when action in ('Added', 'Invalid')
        and dfm.unpublished = 'True' then 'Dont Send'
    end as Journeyaction,
    case
        when q.action = 'Published' then concat(q.entityid, q.uniqueid, c.id, 'EventPublished')
        when q.action = 'Added' then concat(q.entityid, q.uniqueid, c.id, 'EventAdded')
        when q.action = 'Invalid' then concat(q.entityid, q.uniqueid, c.id, 'EventInvalid')
    end as NewId,
    dfm.forumTitle,
    q.entityid as discussionforumid,
    concat(c.id, q.entityid, 'Event1') as uniqueid1,
    concat(c.id, q.entityid, 'Event2') as uniqueid2,
    concat(c.id, q.entityid, 'Event3') as uniqueid3
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
    inner join contact_salesforce as c on c.id = q.Contactid
    left join user_Salesforce as u on u.ContactId = c.id
where
    q.contactid is not null
    and query = 'False'
    and q.entitytype = 'Discussion Forum'
    and u.IsActive = 1
    and c.id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.action in ('Published', 'Added', 'Invalid')