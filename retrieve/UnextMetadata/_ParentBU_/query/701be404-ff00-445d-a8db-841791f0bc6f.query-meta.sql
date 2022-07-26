select
    distinct dfs1.contactid,
    dfs1.discussionforumid,
    dfs1.newid,
    case
        when dfs1.uniqueid in (
            select
                concat(contactid, q.entityid)
            from
                [Discussion Forum LMS] as q
            where
                action = 'Invalid'
                and query = 'False'
                and q.contactid is not null
        ) then 'True'
        else 'False'
    end as Invalid
from
    [Discussion Forum Sendable 1] as dfs1
    inner join [Discussion Forum LMS] as df on dfs1.discussionforumid = df.entityid
where
    df.action = 'Invalid'
    and df.query = 'False'
    and df.contactid is not null