Select
    distinct qs.uniqueId,
    q.entityId as assignmentId
from
    [Assignment Sendable] as qs
    inner join [LMS API Event Entry DE] as q on q.entityId = qs.assignmentId
where
    q.entityType = 'Assignment'
    and qs.action = 'Published'
    and qs.sentStatus = 'True'
    and q.query = 'False'
    and q.action IN('Published', 'Added')
    and qs.uniqueId not IN (
        select
            uniqueId
        from
            [Assignment Unpublished]
    )