select
    distinct c.id as contactid,
    ce.hed__Course_Offering__c as courseofferingid,
    c.lumen__unContact_Name__c as Name,
    c.email as emailaddress,
    c.phone as PhoneNumber,
    u.id as UserId,
    ce.createddate,
    a.name as program,
    ce.lumen__unCourse_Name__c as CourseName,
    a.id as ProgramId,
    a.parentId as Parentid,
    concat(c.id, ce.id) as uniqueid
from
    contact_salesforce as c
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Contact__c = c.id
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    datediff(minute, ce.createddate, getdate()) <= 20
    and c.id not in (
        select
            contactid
        from
            [New Students Enrolled]
    )
    and c.id in (
        Select
            hed__Contact__c
        from
            HED__PROGRAM_ENROLLMENT__C_SALESFORCE
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and u.IsActive = 1