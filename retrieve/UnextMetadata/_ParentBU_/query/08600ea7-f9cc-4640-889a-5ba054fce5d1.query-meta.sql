select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Live Classroom Sendable] as dfs on dfs.liveclassroomid = q.entityid
where
    q.entitytype = 'Live Classroom'
    and q.action in ('Published', 'Added')
    and q.query = 'False'