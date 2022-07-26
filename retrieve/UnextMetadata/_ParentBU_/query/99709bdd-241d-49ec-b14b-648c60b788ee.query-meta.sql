Select
    a.startDate,
    a.endDate,
    a.entityId as assignmentId,
    a.entityTitle,
    a.entityLink
from
    [LMS API Event Entry DE] as a
    inner join [Assignment Master Data] as am on am.assignmentId = a.entityId
where
    a.action = 'Edited'
    and a.query = 'False'
    and a.entityType = 'Assignment'