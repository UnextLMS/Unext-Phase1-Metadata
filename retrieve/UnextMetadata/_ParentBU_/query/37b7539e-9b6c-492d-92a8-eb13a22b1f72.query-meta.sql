select
    distinct c.id as ContactId,
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
    case
        when q.action = 'Invalid' then 'EventDeletion'
        when q.action = 'Published'
        OR q.action = 'Added' then 'EventPublished'
    end as Action,
    case
        when q.action = 'Published' then concat(q.entityId, q.uniqueId, c.Id, 'EventPublished')
        when q.action = 'Added' then concat(q.entityId, q.uniqueId, c.Id, 'EventAdded')
        when q.action = 'Invalid' then concat(q.entityId, q.uniqueId, c.Id, 'EventInvalid')
    end as NewId,
    case
        when action = 'Published' then 'Send'
        when action in ('Added', 'Invalid')
        and qm.unpublished = 'False' then 'Send'
        when action in ('Added', 'Invalid')
        and qm.unpublished = 'True' then 'Dont Send'
    end as Journeyaction,
    qm.liveClassroomTitle,
    q.entityId as liveClassroomId,
    concat(c.Id, q.entityId, 'Event1') as uniqueId1,
    concat(c.Id, q.entityId, 'Event2') as uniqueId2,
    concat(c.Id, q.entityId, 'Event3') as uniqueId3
from
    [LMS API Event Entry DE] as q
    inner join [Live Classroom Master Data] as qm on qm.liveClassroomId = q.entityId
    inner join contact_salesforce as c on c.Id = q.contactId
    left join user_Salesforce as u on u.contactId = c.Id
where
    q.contactId is not null
    and q.query = 'False'
    and q.entityType = 'Live Classroom'
    and c.Id IN (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.action IN ('Published', 'Added', 'Invalid')
    and u.IsActive = 1