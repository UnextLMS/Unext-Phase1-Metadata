select
    distinct ns.ContactId,
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
    'EventPublished' as Action,
    concat(
        dfm.discussionforumid,
        ns.userid,
        ns.contactid,
        'EventPublished'
    ) as NewId,
    dfm.ForumTitle,
    dfm.discussionforumid,
    concat(ns.contactid, dfm.discussionforumid, 'Event1') as uniqueid1,
    concat(ns.contactid, dfm.discussionforumid, 'Event2') as uniqueid2,
    concat(ns.contactid, dfm.discussionforumid, 'Event3') as uniqueid3,
    ns.courseofferingid,
    ns.program,
    ns.userid
from
    [New Students Enrolled] as ns
    inner join [LMS API Event Entry DE] as q on q.courseofferingid = ns.courseofferingid
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
where
    dfm.unpublished = 'False'
    and ns.query = 'False'
    and q.entitytype = 'Discussion Forum'
    and ns.groupid is not null