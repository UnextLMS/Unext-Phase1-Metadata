select
    'True' as query,
    startDate,
    endDate,
    uniqueId
from
    [LMS API Event Entry DE]
where
    datediff(minute, recordcreateddate, getdate()) >= 1
    and entitytype = 'Assignment'