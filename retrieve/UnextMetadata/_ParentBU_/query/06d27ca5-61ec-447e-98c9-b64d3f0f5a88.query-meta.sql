select
    distinct con.Id as contactId,
    con.email as emailAddress,
    con.phone as phoneNumber,
    con.firstName,
    q.ProgramPlanId,
    q.quizLink,
    q.courseOfferingId,
    u.Id as UserId,
    q.newStartDate,
    q.newEndDate,
    q.choice,
    q.type,
    concat(con.Id, q.quizId) as uniqueId,
    'Published' as action,
    'In' as Locale,
    q.startDate,
    q.endDate,
    q.quizTitle,
    ce.unCourse_Name__c as courseName,
    ce.hed__Program_Enrollment__c as programEnrollmentId,
    case
        when ce.createdDate > q.startDate
        and ce.createdDate <= q.endDate then 'True'
        else 'False'
    end as NewUser
from
    [Learner Quiz LMS] as q
    inner join contact_salesforce as con on con.Id = q.ContactId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Contact__c = con.Id
    left join user_Salesforce as u on u.contactId = con.Id
where
    q.contactId is not null
    and con.Id In(
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and q.courseOfferingId = ce.hed__Course_Offering__c
    and concat(con.Id, quizId) not In (
        select
            uniqueId
        from
            [Learner Quiz Invalid Individual Contacts]
    )
    and q.action = 'Published'
    and concat(con.Id, quizId) not In(
        select
            uniqueid
        from
            [Learner Quiz Unpublished]
    )