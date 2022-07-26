select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Sendable] as dfs on dfs.quizId = q.entityid
where
    q.entitytype = 'Quiz'
    and q.action = 'Report Published'
    and q.query = 'False'