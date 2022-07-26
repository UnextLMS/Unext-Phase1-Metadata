select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Sendable] as qs on qs.discussionforumId = q.entityid
where
    q.entitytype = 'Discussion Forum'
    and q.action = 'Edited'
    and q.query = 'False'