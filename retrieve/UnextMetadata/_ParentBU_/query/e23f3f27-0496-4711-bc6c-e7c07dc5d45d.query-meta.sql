SELECT
    ContactKey,
    Attempted,
    StartDate,
    EndDate,
    startTime,
    dateadd(minute, -15, convert(DATETIME, startTime)) As RemTime
from
    TestRemTime