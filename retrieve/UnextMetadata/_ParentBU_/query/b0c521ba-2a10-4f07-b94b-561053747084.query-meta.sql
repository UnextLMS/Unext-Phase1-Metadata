select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Sendable] as dfs on dfs.quizid = q.entityid
where
    q.entitytype = 'Quiz'
    and q.action = 'Invalid'
    and q.query = 'False'