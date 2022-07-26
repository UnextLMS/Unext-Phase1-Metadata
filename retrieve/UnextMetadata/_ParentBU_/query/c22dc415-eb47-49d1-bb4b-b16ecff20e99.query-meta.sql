select
    'True' as Query,
    startdate,
    enddate,
    uniqueid
from
    [Discussion Forum LMS]
where
    action = 'Remainder'