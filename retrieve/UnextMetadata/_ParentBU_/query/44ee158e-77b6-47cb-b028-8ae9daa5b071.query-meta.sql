select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
where
    q.entitytype = 'Assignment'
    and q.action in ('Published', 'Added')
    and target = 'All'
    and q.query = 'False'