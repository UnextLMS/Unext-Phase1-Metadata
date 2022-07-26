Select
    q.userid,
    q.entitytitle as forumtitle,
    q.entitylink as forumlink,
    q.courseofferingid,
    q.learnername,
    q.entityid as discussionforumid,
    u.email as emailaddress,
    u.name,
    u.MobilePhone as PhoneNumber,
    case
        when action = 'Thread Posted' then 'Thread Posted'
        when action = 'New Question' then 'New Question'
    end as Action,
    concat(q.entityid, q.uniqueid, q.userid, q.action) as Newid,
    concat(q.userid, q.entityid) as uniqueid,
    case
        when action = 'Thread Posted' then 'New Thread Posted'
        when action = 'New Question' then 'New Question Posted'
    end as Title,
    case
        when action = 'Thread Posted' then concat(
            q.learnername,
            ' ',
            'have posted a new thread in',
            ' ',
            q.entitytitle
        )
        when action = 'New Question' then concat(
            q.learnername,
            ' ',
            'has posted a new question under',
            ' ',
            q.topicname
        )
    end as Body
from
    [LMS API Event Entry DE] as q
    inner join User_Salesforce as u on u.id = q.userid
where
    q.entitytype = 'Discussion Forum'
    and q.userid is not null
    and q.action in ('Thread Posted', 'New Question')
    and q.Target is null
    and q.groupid is null
    and q.contactid is null
    and q.query = 'False'
    and u.IsActive = 1
    and concat(q.entityid, q.uniqueid, q.userid, q.action) not in (
        select
            newid
        from
            [Faculty Discussion Forum]
    )