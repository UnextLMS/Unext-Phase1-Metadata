select
    distinct c.id as ContactId,
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
    case
        when q.action = 'Invalid' then 'EventDeletion'
        when q.action = 'Published' then 'EventPublished'
    end as Action,
    case
        when action = 'Published' then 'Send'
        when action in ('Added', 'Invalid')
        and qm.unpublished = 'False' then 'Send'
        when action in ('Added', 'Invalid')
        and qm.unpublished = 'True' then 'Dont Send'
    end as Journeyaction,
    case
        when q.action = 'Published' then concat(q.entityId, q.uniqueId, c.Id, 'EventPublished')
        when q.action = 'Added' then concat(q.entityId, q.uniqueId, c.Id, 'EventAdded')
        when q.action = 'Invalid' then concat(q.entityId, q.uniqueId, c.Id, 'EventInvalid')
    end as NewId,
    qm.quizTitle,
    q.groupId,
    q.entityId as quizId,
    concat(c.Id, q.entityId, 'Event1') as uniqueId1,
    concat(c.Id, q.entityId, 'Event2') as uniqueId2,
    concat(c.Id, q.entityId, 'Event3') as uniqueId3
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Master Data] as qm on qm.quizId = q.entityId
    inner join lumen__unUser_Group__c_Salesforce as ug on ug.id = q.groupId
    inner join lumen__unUser_Group_Member__c_Salesforce as ugm on ugm.lumen__unGroup__c = ug.id
    inner join contact_Salesforce as c on c.Id = ugm.lumen__unContact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    q.groupid is not null
    and query = 'False'
    and q.entitytype = 'Quiz'
    and u.isactive = 1
    and ug.lumen__unActive__c = 1
    and c.Id IN (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.action in ('Published', 'Added', 'Invalid')