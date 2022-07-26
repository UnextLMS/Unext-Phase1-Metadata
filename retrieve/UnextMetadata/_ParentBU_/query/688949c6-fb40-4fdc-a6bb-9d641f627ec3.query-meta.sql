select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Assignment Sendable] as asg on asg.assignmentid = q.entityid
where
    q.entitytype = 'Assignment'
    and q.action = 'Report Published'
    and q.query = 'False'