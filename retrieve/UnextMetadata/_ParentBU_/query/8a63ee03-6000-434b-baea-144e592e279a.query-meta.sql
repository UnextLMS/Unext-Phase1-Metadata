select
    distinct dfs1.contactid,
    dfs1.discussionforumid,
    case
        when dfs1.uniqueid not in (
            select
                concat(c.id, q.discussionforumid)
            from
                [Discussion Forum LMS] as q
                inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
                inner join contact_salesforce as c on c.id = ce.hed__Contact__c
                left join user_Salesforce as u on u.ContactId = c.id
            where
                action = 'Published'
                and query = 'False'
                and Target = 'All'
        ) then 'True'
        else 'False'
    end as Invalid,
    NewId,
    df.startdate,
    df.enddate
from
    [Discussion Forum Sendable 1] as dfs1
    inner join [Discussion Forum LMS] as df on df.discussionforumid = dfs1.discussionforumid
where
    dfs1.action = 'Published'