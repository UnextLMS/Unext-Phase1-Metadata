select
    q.startDate,
    q.endDate,
    q.entityId as liveClassroomId,
    q.entityTitle,
    q.entityLink
from
    [LMS API Event Entry DE] as q
    inner join [Live Classroom Master Data] as qs on qs.liveClassroomId = q.entityId
where
    q.action = 'Edited'
    and q.query = 'False'
    and q.entityType = 'Live Classroom'