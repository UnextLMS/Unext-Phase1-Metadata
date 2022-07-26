select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Faculty Assignment] as qs on qs.AssignmentId = q.entityid
where
    entitytype = 'Assignment'
    and q.action in (
        'Submission Request',
        'Reattempt Request',
        'Challenge Question Request'
    )
    and q.query = 'False'