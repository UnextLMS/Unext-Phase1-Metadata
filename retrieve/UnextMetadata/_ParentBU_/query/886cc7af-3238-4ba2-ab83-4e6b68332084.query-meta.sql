select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Sendable] as dfs on dfs.quizid = q.entityid
where
    entitytype = 'Quiz'
    and q.action = 'UnPublished'
    and q.query = 'False'