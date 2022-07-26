select
    distinct ns.ContactId,
    dateadd(hour, 10, dateadd(minute, 30, qm.startdate)) as eventSD,
    case
        when datediff(day, qm.startDate, qm.endDate) = 1
        or datediff(day, qm.startDate, qm.endDate) = 0 then qm.startDate
        else dateadd(day, 1, qm.startDate)
    end as allDayEventSD,
    case
        when datediff(day, qm.startDate, qm.endDate) = 1
        or datediff(day, qm.startDate, qm.endDate) = 0 then qm.endDate
        else dateadd(day, 1, qm.endDate)
    end as allDayEventED,
    dateadd(hour, 10, dateadd(minute, 30, qm.endDate)) as eventED,
    dateadd(
        second,
        -1,
        dateadd(
            day,
            1,
            dateadd(
                day,
                0 + datediff(day, '19000101', qm.startDate),
                '19000101'
            )
        )
    ) as eventNSD,
    case
        when datepart(month, qm.endDate) = 5 then dateadd(
            second,
            -1,
            dateadd(
                day,
                1,
                dateadd(
                    day,
                    1 + datediff(day, '19000101', qm.endDate),
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
                    0 + datediff(day, '19000101', qm.endDate),
                    '19000101'
                )
            )
        )
    end as eventNED,
    'EventPublished' as Action,
    qm.assignmentTitle,
    qm.assignmentId,
    ns.courseofferingid,
    ns.program,
    ns.userid,
    concat(
        qm.assignmentId,
        ns.userid,
        ns.contactid,
        'EventPublished'
    ) as NewId,
    concat(ns.contactid, qm.assignmentId, 'Event1') as uniqueid1,
    concat(ns.contactid, qm.assignmentId, 'Event2') as uniqueid2,
    concat(ns.contactid, qm.assignmentId, 'Event3') as uniqueid3
from
    [New Students Enrolled] as ns
    inner join [LMS API Event Entry DE] as q on q.courseOfferingId = ns.courseofferingid
    inner join [Assignment Master Data] as qm on qm.assignmentId = q.entityId
where
    q.Invalid = 'False'
    and q.action = 'Published'
    and qm.unpublished = 'False'
    and ns.query = 'False'
    and q.entityType = 'Assignment'
    and ns.groupId is null