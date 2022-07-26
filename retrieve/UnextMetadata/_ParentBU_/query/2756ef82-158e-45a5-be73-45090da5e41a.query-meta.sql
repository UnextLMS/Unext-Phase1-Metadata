select
    distinct lc.contactId,
    lc.liveClassroomId,
    case
        when lc.uniqueId not IN (
            select
                concat(contactId, lc.liveClassroomId)
            from
                [Learner Live Classroom LMS] as lc
            where
                action = 'Published'
                and query = 'False'
                and lc.contactId is not null
        ) then 'True'
        else 'False'
    end as Invalid,
    newId,
    lc.startDate,
    lc.startTime
from
    [Learner Live Classroom Sendable] as lcs
    inner join [Learner Live Classroom LMS] as lc on lc.liveClassroomId = lcs.liveClassroomId
where
    lcs.action = 'Published'
    and lc.contactId is not null