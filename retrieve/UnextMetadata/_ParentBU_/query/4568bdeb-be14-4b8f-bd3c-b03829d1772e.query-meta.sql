select
    distinct qm.ContactId,
    dateadd(hour, 10, dateadd(minute, 30, q.startDate)) as EventSD,
    case
        when datediff(day, qm.startdate, q.enddate) = 1
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
        when q.action = 'Edited' then concat(q.entityId, q.uniqueId, qm.contactId, 'EventEdited')
        when q.action = 'UnPublished' then concat(
            q.entityId,
            q.uniqueId,
            qm.contactId,
            'EventUnPublished'
        )
        when q.action = 'Deleted' then concat(
            q.entityId,
            q.uniqueId,
            qm.contactId,
            'EventDeleted'
        )
    end as newId,
    qm.quizTitle,
    q.entityId as quizId,
    concat(qm.contactId, q.entityId, 'Event1') as uniqueId1,
    concat(qm.contactId, q.entityId, 'Event2') as uniqueId2,
    concat(qm.contactId, q.entityId, 'Event3') as uniqueId3
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Sendable] as qm on q.entityid = qm.quizId
where
    q.action in ('Edited', 'UnPublished', 'Deleted')
    and q.query = 'False'
    and qm.action = 'Published'
    and q.entityType = 'Quiz'