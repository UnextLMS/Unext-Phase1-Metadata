select
    'True' as query,
    startDate,
    endDate,
    uniqueId
from
    [LMS API Event Entry DE]
where
    datediff(minute, recordCreatedDate, getdate()) >= 1
    and entityType = 'Quiz'