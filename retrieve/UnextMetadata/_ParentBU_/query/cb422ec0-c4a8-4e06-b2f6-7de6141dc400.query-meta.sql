select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Sendable] as dfs on dfs.NewId = concat(q.entityid, q.uniqueid, q.contactid, q.action)
where
    q.entitytype = 'Quiz'
    and q.action in ('Published', 'Added')
    and target = 'All'
    and dfs.sentStatus = 'False'
    and q.query = 'False'