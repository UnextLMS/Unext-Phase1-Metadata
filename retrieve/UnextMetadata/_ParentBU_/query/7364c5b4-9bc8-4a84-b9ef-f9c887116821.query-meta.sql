Select
    q.userId,
    q.entityTitle as quizTitle,
    q.entityLink as quizLink,
    q.entityId as quizId,
    q.courseOfferingId,
    q.learnerName,
    case
        when q.action = 'Submission Request' then 'Submission Request'
        when q.action = 'Reattempt Request' then 'Reattempt Request'
        when q.action = 'Challenge Question Request' then 'Challenge Question Request'
    end as action,
    case
        when q.action = 'Submission Request' then 'New Submission Request'
        when q.action = 'Reattempt Request' then 'New Reattempt Request'
        when q.action = 'Challenge Question Request' then 'New Challenge Question Request'
    end as title,
    case
        when q.action = 'Submission Request' then concat(
            q.learnerName,
            ' ',
            'submission approval request for Quiz',
            ' ',
            q.entityTitle,
            ' ',
            'has been raised',
            ' ',
            'as',
            ' ',
            'the validity 
is expired',
            '.'
        )
        when q.action = 'Reattempt Request' then concat(
            q.learnerName,
            ' ',
            'Reattempt approval request for Quiz',
            ' ',
            q.entityTitle,
            ' ',
            'has been raised',
            '.'
        )
        when q.action = 'Challenge Question Request' then concat(
            q.learnerName,
            ' ',
            'Challenge Question request for Quiz',
            ' ',
            q.entityTitle,
            ' ',
            'has been raised',
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
    q.entityType = 'Quiz'
    and q.userId is not null
    and q.action IN(
        'Submission Request',
        'Reattempt Request',
        'Challenge Question Request'
    )
    and q.target is null
    and q.groupId is null
    and q.contactId is null
    and query = 'False'