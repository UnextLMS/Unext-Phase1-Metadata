select
    distinct con.Id as contactId,
    con.email as emailAddress,
    con.phone as phoneNumber,
    con.firstName,
    q.programPlanId,
    q.quizLink,
    q.courseOfferingId,
    q.quizId,
    q.newStartDate,
    q.newEndDate,
    q.choice,
    q.type,
    concat(con.Id, q.quizId) as uniqueId,
    'Published' as action,
    'IN' as Locale,
    q.startDate,
    q.endDate,
    q.quizTitle,
    case
        when ugm.createdDate > q.startDate
        and ugm.createdDate <= endDate then 'True'
        else 'False'
    end as NewUser,
    ce.unCourse_Name__c as CourseName,
    q.groupId
from
    [Learner Quiz LMS] as q
    inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.Id = q.groupId
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = ug.unCourse_Offering__c
    inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.id
    inner join contact_Salesforce as con on con.Id = ugm.unContact__c
where
    groupId is not null
    and con.Id IN(
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and concat(con.Id, quizId) not IN (
        select
            uniqueId
        from
            [Learner Quiz Invalid Individual Contacts]
    )
    and concat(con.Id, q.quizId) not IN (
        select
            uniqueId
        from
            [Learner Quiz Unpublished]
    )