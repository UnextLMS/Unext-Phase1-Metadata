select
    distinct dfs1.contactid,
    dfs1.discussionforumid,
    case
        when dfs1.uniqueid in (
            select
                concat(c.id, q.entityid) as uniqueid
            from
                [Discussion Forum LMS] as q
                inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
                inner join contact_salesforce as c on c.id = ce.hed__Contact__c
                left join user_Salesforce as u on u.ContactId = c.id
            where
                q.action = 'Invalid'
                and q.query = 'False'
                and q.Target = 'All'
        ) then 'True'
        when dfs1.uniqueid in (
            select
                concat(c.id, q.entityid) as uniqueid
            from
                [Discussion Forum LMS] as q
                inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
                inner join contact_salesforce as c on c.id = ce.hed__Contact__c
                left join user_Salesforce as u on u.ContactId = c.id
            where
                q.action = 'Added'
                and q.query = 'False'
                and q.Target = 'All'
        ) then 'False'
    end as Invalid,
    NewId,
    df.startdate,
    df.enddate,
    dfs1.uniqueid
from
    [Discussion Forum Sendable 1] as dfs1
    inner join [Discussion Forum LMS] as df on df.entityid = dfs1.discussionforumid
where
    (
        df.action = 'Invalid'
        or df.action = 'Added'
    )
    and df.Target = 'All'
    and df.query = 'False'