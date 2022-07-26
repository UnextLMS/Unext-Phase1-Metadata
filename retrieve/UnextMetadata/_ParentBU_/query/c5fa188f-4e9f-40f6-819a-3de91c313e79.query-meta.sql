select
    sum(
        case
            when datepart(day, df.recordcreateddate) = datepart(day, getdate()) then 1
            else 0
        end
    ) as recordcreateddatecount,
    df.DiscussionForumId,
    df.action
from
    [Discussion Forum LMS] as df
group by
    df.discussionforumid,
    df.action