select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
where
    q.entitytype = 'Discussion Forum'
    and q.action = 'UnPublished'
    and q.query = 'False'