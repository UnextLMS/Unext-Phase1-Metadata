select
    distinct dfs1.contactid,
    dfs1.discussionforumid,
    case
        when dfs1.uniqueid in (
            select
                concat(c.id, q.entityid)
            from
                [Discussion Forum LMS] as q
                inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.id = q.groupid
                inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.id
                inner join contact_Salesforce as c on c.id = ugm.unContact__c
            where
                action = 'Invalid'
                and query = 'False'
                and groupid is not null
        ) then 'True'
        when dfs1.uniqueid in (
            select
                concat(c.id, q.entityid)
            from
                [Discussion Forum LMS] as q
                inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.id = q.groupid
                inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.id
                inner join contact_Salesforce as c on c.id = ugm.unContact__c
            where
                action = 'Added'
                and query = 'False'
                and groupid is not null
        ) then 'False'
    end as Invalid,
    NewId,
    df.startdate,
    df.enddate,
    df.groupid
from
    [Discussion Forum Sendable 1] as dfs1
    inner join [Discussion Forum LMS] as df on df.entityid = dfs1.discussionforumid
where
    (
        df.action = 'Invalid'
        or df.action = 'Published'
    )
    and df.groupid is not null
    and df.query = 'False'