select
    liveclassroomid,
    liveclassroomtitle,
    coursename,
    startdate,
    enddate,
    userid,
    action,
    sentstatus,
    uniqueid,
    newid
from
    [Live Classroom Sendable]
where
    sentstatus = 'False'
    and journeyaction = 'Send'
    and action in ('Published')