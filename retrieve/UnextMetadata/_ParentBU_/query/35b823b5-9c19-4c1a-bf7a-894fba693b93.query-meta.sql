select
    distinct cont.id as ContactId,
    cont.email as emailAddress,
    cont.phone as phoneNumber,
    cont.firstName,
    cal.programPlanId,
    cal.courseOfferingId,
    cal.taskDate,
    cal.taskTime,
    cal.taskRemTime,
    cal.uniqueId,
    'IN' as locale
from
    [Learner Calender LMS] as cal
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.id = cal.programEnrollmentId
    inner join contact_salesforce as cont on cont.id = pe.hed__Contact__c
    left join user_Salesforce as u on u.ContactId = cont.id
where
    cont.id IN(
        select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'