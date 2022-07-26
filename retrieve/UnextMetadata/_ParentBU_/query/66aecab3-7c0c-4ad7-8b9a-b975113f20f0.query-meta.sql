select
    'True' as Query,
    startdate,
    enddate,
    uniqueid
from
    [LMS API Event Entry DE]
where
    entitytype = 'Discussion Forum'
    and action not in ('UnPublished', 'Invalid', 'Added')