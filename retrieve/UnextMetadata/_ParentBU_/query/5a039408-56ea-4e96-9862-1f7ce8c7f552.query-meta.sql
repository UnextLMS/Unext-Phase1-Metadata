select
    distinct asg.contactId,
    asg.assignmentId,
    case
        when asg.uniqueId not IN (
            select
                concat(contactId, asg.assignmentId)
            from
                [Learner Assignment LMS] as asg
            where
                action = 'Published'
                and query = 'False'
                and asg.contactId is not null
        ) then 'True'
        else 'False'
    end as Invalid,
    newId,
    asg.startDate,
    asg.endDate
from
    [Learner Assignment Sendable] as asgs
    inner join [Learner Assignment LMS] as asg on asg.assignmentId = asgs.assignmentId
where
    asgs.action = 'Published'
    and asg.contactId is not null