select
    distinct dfs1.Uniqueid,
    df.entityid as discussionforumid
from
    [Discussion Forum Sendable] as dfs1
    inner join [LMS API Event Entry DE] as df on df.entityid = dfs1.discussionforumid
where
    df.entitytype = 'Discussion Forum'
    and dfs1.action = 'Published'
    and dfs1.sent = 'True'
    and df.query = 'False'
    and df.action in ('Published', 'Added')
    and dfs1.uniqueid not in (
        select
            uniqueid
        from
            [Discussion Forum Unpublished]
    )