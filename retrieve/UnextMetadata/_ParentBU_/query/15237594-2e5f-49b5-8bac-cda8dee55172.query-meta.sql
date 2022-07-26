Select
    q.userId,
    q.entityTitle,
    q.entityLink,
    q.entityId,
    q.courseOfferingId,
    q.learnerName,
    case
        when q.action = 'New Question' then 'New Question'
    end as action,
    case
        when q.action = 'New Question' then 'New Question Posted'
    end as title,
    case
        when q.action = 'New Question' then concat(
            q.learnerName,
            ' ',
            'has posted a new question under',
            ' ',
            q.entityTitle,
            '.'
        )
    end as body,
    concat(q.entityId, q.uniqueId, q.userId, q.action) as newId,
    concat(q.userId, q.entityId) as uniqueId,
    u.email as emailAddress,
    u.name,
    u.MobilePhone as phoneNumber
from
    [LMS API Event Entry DE] as q
    inner join User_Salesforce as u on u.id = q.userId
where
    q.entityType = 'QA'
    and q.userId is not null
    and q.action = 'New Question'
    and q.target is null
    and q.groupId is null
    and q.contactId is null