SELECT
    uniqueId,
    startDate,
    startTime,
    dateadd(minute, -15, convert(DATETIME, startTime)) As remTime
from
    [Learner Live Classroom LMS]