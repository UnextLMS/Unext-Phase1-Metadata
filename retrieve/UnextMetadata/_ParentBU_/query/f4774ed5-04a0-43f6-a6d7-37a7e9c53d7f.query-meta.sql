select
    distinct con.Id as ContactID,
    con.email as emailAddress,
    con.phone as PhoneNumber,
    con.firstname,
    q.quizLink,
    q.courseOfferingId,
    q.quizId,
    q.newStartDate,
    q.newEndDate,
    q.choice,
    q.type,
    'Remainder' as action,
    concat(con.Id, q.quizId) as uniqueId,
    'False' as Attempted,
    'IN' as Locale,
    q.startDate,
    q.enddate,
    q.quizTitle,
    ce.unCourse_Name__c as courseName,
    ce.hed__Program_Enrollment__c as programEnrollmentId,
    'quiz Remainder' as Title,
    concat('complete the Quiz before', q.endDate) as Body,
    q.UserId as userId
from
    [Learner Quiz LMS] as q
    inner join contact_salesforce as con on con.id = q.contactId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Contact__c = con.Id
where
    datepart(day, dateadd(day, -1, enddate)) = datepart(day, GETUTCDATE())
    and con.Id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and concat(con.Id, quizId) not in (
        select
            uniqueid
        from
            [Learner Quiz Invalid Contacts]
    )