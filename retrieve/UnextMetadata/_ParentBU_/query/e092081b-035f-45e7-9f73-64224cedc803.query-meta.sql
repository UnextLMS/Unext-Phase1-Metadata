select
    distinct c.id as contactid,
    c.lumen__unContact_Name__c as Name,
    c.email as emailaddress,
    c.phone as PhoneNumber,
    u.id as UserId,
    ug.id as GroupId,
    a.name as Program,
    a.parentid as parentid,
    concat(c.id, ugm.id) as uniqueid
from
    contact_Salesforce as c
    inner join lumen__unUser_Group_Member__c_Salesforce as ugm on ugm.lumen__unContact__c = c.id
    inner join lumen__UNUSER_GROUP__C_SALESFORCE as ug on ug.id = ugm.lumen__unGroup__c
    inner join hed__Program_Plan__c_Salesforce as pp on pp.id = ug.lumen__unProgram_Plan__c
    inner join account_Salesforce as a on a.id = pp.hed__Account__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    datediff(minute, ugm.createddate, getdate()) <= 20
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
    and ug.lumen__unActive__c = 1