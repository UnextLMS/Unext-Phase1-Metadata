select
    'True' as Query,
    q.startdate,
    q.enddate,
    q.uniqueid
from
    [LMS API Event Entry DE] as q
    inner join [Faculty Discussion Forum] as qs on qs.discussionforumId = q.entityid
where
    entitytype = 'Discussion Forum'
    and q.action in ('Thread Posted', 'New Question')
    and q.query = 'False'