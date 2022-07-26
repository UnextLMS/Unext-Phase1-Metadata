Select
    distinct qs.uniqueId,
    q.entityId as liveClassroomId
from
    [Live Classroom Sendable] as qs
    inner join [LMS API Event Entry DE] as q on q.entityId = qs.liveClassroomId
where
    q.entityType = 'Live Classroom'
    and qs.action = 'Published'
    and qs.sentStatus = 'True'
    and q.query = 'False'
    and q.action IN('Published', 'Added')
    and qs.uniqueId not IN (
        select
            uniqueId
        from
            [Live Classroom Unpublished]
    )