select
    distinct dfm.ContactId,
    dateadd(hour, 10, dateadd(minute, 30, q.startdate)) as EventSD,
    case
        when datediff(day, q.startdate, q.enddate) = 1
        or datediff(day, q.startdate, q.enddate) = 0 then q.startdate
        else dateadd(day, 1, q.startdate)
    end as AllDayEventSD,
    case
        when datediff(day, q.startdate, q.enddate) = 1
        or datediff(day, q.startdate, q.enddate) = 0 then q.enddate
        else dateadd(day, -1, q.enddate)
    end as AllDayEventED,
    dateadd(hour, 10, dateadd(minute, 30, q.enddate)) as EventED,
    dateadd(
        second,
        -1,
        dateadd(
            day,
            1,
            dateadd(
                day,
                0 + datediff(day, '19000101', q.StartDate),
                '19000101'
            )
        )
    ) as EventNSD,
    case
        when datepart(month, q.enddate) = 5 then dateadd(
            second,
            -1,
            dateadd(
                day,
                1,
                dateadd(
                    day,
                    1 + datediff(day, '19000101', q.endDate),
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
                    0 + datediff(day, '19000101', q.endDate),
                    '19000101'
                )
            )
        )
    end as EventNED,
    case
        when q.action = 'UnPublished'
        or q.action = 'Deleted' then 'EventDeletion'
        when q.action = 'Edited' then 'EventEdited'
    end as Action,
    case
        when q.action = 'Edited' then concat(
            q.entityid,
            q.uniqueid,
            dfm.contactid,
            'EventEdited'
        )
        when q.action = 'UnPublished' then concat(
            q.entityid,
            q.uniqueid,
            dfm.contactid,
            'EventUnPublished'
        )
        when q.action = 'Deleted' then concat(
            q.entityid,
            q.uniqueid,
            dfm.contactid,
            'EventDeleted'
        )
    end as NewId,
    q.EntityTitle as ForumTitle,
    q.entityid as discussionforumid,
    concat(dfm.contactid, q.entityid, 'Event1') as uniqueid1,
    concat(dfm.contactid, q.entityid, 'Event2') as uniqueid2,
    concat(dfm.contactid, q.entityid, 'Event3') as uniqueid3
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Sendable] as dfm on q.entityid = dfm.discussionforumid
where
    q.action in ('Edited', 'UnPublished', 'Deleted')
    and q.query = 'False'
    and dfm.action = 'Published'
    and q.Invalid = 'False'
    and q.entitytype = 'Discussion Forum'