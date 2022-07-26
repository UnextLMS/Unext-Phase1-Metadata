select
    distinct qs.contactId,
    qs.quizId,
    case
        when qs.uniqueId not IN (
            select
                concat(con.Id, quizId)
            from
                [Learner Quiz LMS] as q
                inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
                inner join contact_salesforce as con on con.Id = ce.hed__Contact__c
                left join user_Salesforce as u on u.contactId = con.Id
            where
                action = 'Published'
                and query = 'False'
                and Target = 'All'
        ) then 'True'
        else 'False'
    end as Invalid,
    newId,
    q.startDate,
    q.endDate,
    qs.uniqueId
from
    [Learner Quiz Sendable] as qs
    inner join [Learner Quiz LMS] as q on q.quizId = qs.quizId
where
    qs.action = 'Published'
    and q.Target = 'All'