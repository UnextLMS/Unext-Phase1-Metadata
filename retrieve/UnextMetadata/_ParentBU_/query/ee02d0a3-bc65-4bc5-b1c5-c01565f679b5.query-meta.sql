SELECT
    uniqueId,
    taskDate,
    taskTime,
    dateadd(minute, -15, convert(DATETIME, taskTime)) As taskRemTime
from
    [Learner Calender LMS]