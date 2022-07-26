select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Faculty Quiz] as qs on qs.quizid = q.entityid
where
    entitytype = 'Quiz'
    and q.action in (
        'Submission Request',
        'Reattempt Request',
        'Challenge Question Request'
    )
    and q.query = 'False'