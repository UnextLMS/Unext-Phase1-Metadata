select
    distinct qs.contactId,
    qs.quizId,
    case
        when qs.uniqueId not IN (
            select
                concat(con.Id, quizId)
            from
                [Learner Quiz LMS] as q
                inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.Id = q.groupId
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
    q.startDate,
    q.endDate
from
    [Learner Quiz Sendable] as qs
    inner join [Learner Quiz LMS] as q on q.quizId = qs.quizId
where
    qs.action = 'Published'
    and q.groupId is not null