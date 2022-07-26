select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
where
    q.entitytype = 'Assignment'
    and q.action = 'Edited'
    and q.query = 'False'