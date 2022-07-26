Select
    asg.userId,
    asg.entityTitle as assignmentTitle,
    asg.entityLink as assignmentLink,
    asg.entityId as assignmentId,
    asg.courseOfferingId,
    asg.learnerName,
    case
        when asg.action = 'Submission Request' then 'Submission Request'
        when asg.action = 'Reattempt Request' then 'Reattempt Request'
        when asg.action = 'Challenge Question Request' then 'Challenge Question Request'
    end as action,
    case
        when asg.action = 'Submission Request' then 'New Submission Request'
        when asg.action = 'Reattempt Request' then 'New Reattempt Request'
        when asg.action = 'Challenge Question Request' then 'New Challenge Request'
    end as title,
    case
        when asg.action = 'Submission Request' then concat(
            asg.learnerName,
            ' ',
            'submission approval request for Assignment',
            ' ',
            asg.entityTitle,
            ' ',
            'has been raised as the validity 
is expired',
            '.'
        )
        when asg.action = 'Reattempt Request' then concat(
            asg.learnerName,
            ' ',
            'Reattempt approval request for Assignment',
            ' ',
            asg.entityTitle,
            ' ',
            'has been raised',
            '.'
        )
        when asg.action = 'Challenge Question Request' then concat(
            asg.learnerName,
            ' ',
            'Challenge Question request for Assignment',
            ' ',
            asg.entityTitle,
            ' ',
            'has been raised',
            '.'
        )
    end as body,
    concat(asg.entityId, asg.uniqueId, asg.userId, asg.action) as newId,
    concat(asg.userId, asg.entityId) as uniqueId,
    u.email as emailAddress,
    u.name,
    u.MobilePhone as phoneNumber
from
    [LMS API Event Entry DE] as asg
    inner join User_Salesforce as u on u.id = asg.userId
where
    asg.entityType = 'Assignment'
    and asg.userId is not null
    and asg.action IN(
        'Submission Request',
        'Reattempt Request',
        'Challenge Question Request'
    )
    and asg.target is null
    and asg.groupId is null
    and asg.contactId is null
    and query = 'False'
    and concat(asg.entityid, asg.uniqueid, asg.userid, asg.action) not in (
        select
            newid
        from
            [Faculty Assignment]
    )