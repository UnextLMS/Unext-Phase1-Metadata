select
    concat(contactid, discussionforumid) as uniqueid,
    discussionforumid,
    contactid
from
    [Discussion Forum LMS]
where
    action = 'Invalid'
    and query = 'False'