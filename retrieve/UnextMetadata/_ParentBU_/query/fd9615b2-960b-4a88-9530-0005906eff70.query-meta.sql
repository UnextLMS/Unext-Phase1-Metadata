select
    distinct q.contactId,
    q.quizId,
    case
        when q.uniqueId not IN (
            select
                concat(contactId, q.quizId)
            from
                [Learner Quiz LMS] as q
            where
                action = 'Published'
                and query = 'False'
                and q.contactId is not null
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
    and q.contactId is not null