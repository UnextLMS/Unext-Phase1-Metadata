select
    distinct con.Id as ContactId,
    con.email as emailAddress,
    con.phone as phoneNumber,
    con.firstName,
    q.ProgramPlanId,
    q.quizLink,
    q.courseOfferingId,
    q.quizId,
    u.Id as UserId,
    q.newStartDate,
    q.newEndDate,
    concat(con.Id, q.quizId) as uniqueId,
    q.choice,
    q.type,
    'Published' as action,
    'IN' as Locale,
    q.StartDate,
    q.EndDate,
    q.quizTitle,
    ce.unCourse_Name__c as courseName,
    ce.hed__Program_Enrollment__c as ProgramEnrollmentId,
    case
        when ce.createdDate > q.startDate
        and ce.createdDate <= q.endDate then 'True'
        else 'False'
    end as NewUser
from
    [Learner Quiz LMS] as q
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseOfferingId
    inner join contact_salesforce as con on con.id = ce.hed__Contact__c
    left join user_Salesforce as u on u.ContactId = con.Id
where
    Target = 'All'
    and con.Id In (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and concat(con.Id, q.quizId) not In(
        select
            uniqueId
        from
            [Learner Quiz Unpublished]
    )
    and q.action = 'Published'