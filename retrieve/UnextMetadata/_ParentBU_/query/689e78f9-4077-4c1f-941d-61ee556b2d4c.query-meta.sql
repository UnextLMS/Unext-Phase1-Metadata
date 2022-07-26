select
    COUNT(df.recordcreateddate) as recordcreateddatecount,
    df.DiscussionForumId,
    df.action
from
    [Discussion Forum LMS] as df
where
    datepart(day, df.recordcreateddate) = datepart(day, getdate())
    and df.action = 'Remainder'
group by
    df.discussionforumid,
    df.action