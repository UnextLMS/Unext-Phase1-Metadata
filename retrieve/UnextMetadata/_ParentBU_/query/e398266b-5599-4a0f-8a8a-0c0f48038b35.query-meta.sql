select
    distinct asgs.contactId,
    asgs.assignmentId,
    case
        when asgs.uniqueId not IN (
            select
                concat(con.Id, assignmentId)
            from
                [Learner Assignment LMS] as asg
                inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.Id = asg.groupId
                inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.Id
                inner join contact_Salesforce as con on con.Id = ugm.unContact__c
            where
                action = 'Published'
                and query = 'False'
                and groupId is not null
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
    and asg.groupId is not null