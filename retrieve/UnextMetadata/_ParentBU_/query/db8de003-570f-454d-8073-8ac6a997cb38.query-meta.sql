select
    dfl.startdate,
    dfl.enddate,
    dfl.entityid as discussionforumid,
    dfl.entityTitle,
    dfl.entitylink
from
    [LMS API Event Entry DE] as dfl
    inner join [Discussion Forum Master Data] as dfs1 on dfs1.discussionforumid = dfl.entityid
where
    dfl.action = 'Edited'
    and dfl.query = 'False'
    and dfl.entitytype = 'Discussion Forum'