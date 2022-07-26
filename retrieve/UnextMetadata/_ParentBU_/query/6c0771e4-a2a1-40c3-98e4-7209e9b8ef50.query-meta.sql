select
    assignmentid,
    assignmenttitle,
    coursename,
    startdate,
    enddate,
    userid,
    action,
    sentstatus,
    uniqueid,
    newid
from
    [Assignment Sendable]
where
    sentstatus = 'False'
    and journeyaction = 'Send'
    and action in ('Published', 'Remainder', 'Report Published')