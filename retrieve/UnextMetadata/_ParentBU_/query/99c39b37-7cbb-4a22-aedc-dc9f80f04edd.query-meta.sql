select
    max(recordcreateddate) as maxdate,
    discussionforumid
from
    [Discussion Forum LMS]
where
    datepart(day, dateadd(day, -1, enddate)) = datepart(day, GETUTCDATE())
group by
    discussionforumid