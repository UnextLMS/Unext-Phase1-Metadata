select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Live Classroom Sendable] as dfs on dfs.NewId = concat(q.entityid, q.uniqueid, q.contactid, q.action)
where
    q.entitytype = 'Live Classroom'
    and q.action in ('Published', 'Added')
    and dfs.sentStatus = 'False'
    and q.query = 'False'
    and q.contactid is not null