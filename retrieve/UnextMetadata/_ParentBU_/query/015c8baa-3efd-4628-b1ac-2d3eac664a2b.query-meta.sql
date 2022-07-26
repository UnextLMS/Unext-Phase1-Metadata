select
    distinct ns.ContactId,
    dateadd(hour, 10, dateadd(minute, 30, qm.startdate)) as EventSD,
    case
        when datediff(day, qm.startdate, qm.enddate) = 1
        or datediff(day, qm.startdate, qm.enddate) = 0 then qm.startdate
        else dateadd(day, 1, qm.startdate)
    end as AllDayEventSD,
    case
        when datediff(day, qm.startdate, qm.enddate) = 1
        or datediff(day, qm.startdate, qm.enddate) = 0 then qm.enddate
        else dateadd(day, -1, qm.enddate)
    end as AllDayEventED,
    dateadd(hour, 10, dateadd(minute, 30, qm.enddate)) as EventED,
    dateadd(
        second,
        -1,
        dateadd(
            day,
            1,
            dateadd(
                day,
                0 + datediff(day, '19000101', qm.StartDate),
                '19000101'
            )
        )
    ) as EventNSD,
    case
        when datepart(month, qm.enddate) = 5 then dateadd(
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
    end as EventNED,
    'EventPublished' as Action,
    ns.courseOfferingId,
    ns.program,
    ns.userId,
    qm.liveClassroomTitle,
    qm.liveClassroomId,
    concat(
        qm.liveClassroomId,
        ns.userId,
        ns.contactId,
        'EventPublished'
    ) as NewId,
    concat(ns.contactId, qm.liveClassroomId, 'Event1') as uniqueid1,
    concat(ns.contactId, qm.liveClassroomId, 'Event2') as uniqueId2,
    concat(ns.contactId, qm.liveClassroomId, 'Event3') as uniqueId3
from
    [New Students Enrolled] as ns
    inner join [LMS API Event Entry DE] as q on q.courseOfferingId = ns.courseOfferingId
    inner join [Live Classroom Master Data] as qm on qm.liveClassroomId = q.entityId
where
    qm.unpublished = 'False'
    and ns.query = 'False'
    and q.entitytype = 'Live Classroom'
    and ns.groupId is not null