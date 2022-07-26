Select
    distinct c.Id as contactId,
    dateadd(hour, 10, dateadd(minute, 30, qm.startDate)) as eventSD,
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
        when datediff(day, qm.startDate, qm.endDate) = 1
        or datediff(day, qm.startDate, qm.endDate) = 0 then qm.startDate
        else dateadd(day, 1, qm.startDate)
    end as allDayEventSD,
    case
        when datediff(day, qm.startdate, qm.enddate) = 1
        or datediff(day, qm.startdate, qm.enddate) = 0 then qm.enddate
        else dateadd(day, -1, qm.enddate)
    end as AllDayEventED,
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
        or q.action = 'Added' then 'EventPublished'
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
    qm.quizTitle,
    q.entityId as quizId,
    'All' as Target,
    concat(c.Id, q.entityId, 'Event1') as uniqueId1,
    concat(c.Id, q.entityId, 'Event2') as uniqueId2,
    concat(c.Id, q.entityId, 'Event3') as uniqueId3
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Master Data] as qm on qm.quizId = q.entityId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join contact_salesforce as c on c.Id = ce.hed__Contact__c
    left join user_Salesforce as u on u.contactId = c.Id
where
    q.target = 'All'
    and query = 'False'
    and q.entitytype = 'Quiz'
    and u.isactive = 1
    and c.Id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.action in ('Published', 'Added', 'Invalid')