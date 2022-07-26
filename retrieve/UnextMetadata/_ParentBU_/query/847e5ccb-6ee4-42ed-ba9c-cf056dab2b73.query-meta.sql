select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Assignment Sendable] as dfs on dfs.NewId = concat(q.entityid, q.uniqueid, q.contactid, q.action)
where
    q.entitytype = 'Assignment'
    and q.action = 'Report Published'
    and q.contactid is not null
    and dfs.sentStatus = 'False'
    and q.query = 'False'