select
    discussionforumid,
    forumtitle,
    coursename,
    startdate,
    enddate,
    userid,
    action,
    sent,
    uniqueid,
    newid
from
    [Discussion Forum Sendable]
where
    sent = 'False'
    and journeyaction = 'Send'
    and action in ('Published', 'Report Published')