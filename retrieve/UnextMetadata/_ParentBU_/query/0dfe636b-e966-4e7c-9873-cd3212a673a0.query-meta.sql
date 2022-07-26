select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
where
    q.entitytype = 'Discussion Forum'
    and q.action in ('Published', 'Added')
    and q.query = 'False'
    and q.target = 'All'