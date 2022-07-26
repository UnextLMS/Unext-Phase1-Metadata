select
    quizid,
    quiztitle,
    coursename,
    startdate,
    enddate,
    userid,
    action,
    sentstatus,
    uniqueid,
    newid
from
    [Quiz Sendable]
where
    sentstatus = 'False'
    and journeyaction = 'Send'
    and action in ('Published', 'Remainder', 'Report Published')