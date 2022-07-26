Select
    q.startDate,
    q.endDate,
    q.entityId as quizId,
    q.entityTitle,
    q.entityLink
from
    [LMS API Event Entry DE] as q
    inner join [Quiz Master Data] as qm on qm.quizId = q.entityId
where
    q.action = 'Edited'
    and q.query = 'False'
    and q.entityType = 'Quiz'