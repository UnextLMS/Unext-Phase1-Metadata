select
    pe.id as ProgramEnrollmentId,
    c.email as Personalemail,
    c.id as contactid,
    c.phone as PhoneNumber,
    u.id as UserId,
    c.lumen__unUniversity_Email__c as Universityemail,
    pe.lumen__unRoll_Number__c as RollNo,
    lumen__unContact_Name__c as fullname,
    'Manipal University' as University,
    'Jigsaw' as Programtype,
    'www.aethereus.com' as link,
    'New Program Enrollment' as Title,
    u.lumen__Password__c as Password,
    'IN' as Locale,
    lumen__unReset_Link__c as ResetLink,
    username as username
from
    hed__Program_Enrollment__c_Salesforce as pe
    inner join contact_salesforce as c on c.id = pe.hed__Contact__c
    inner join user_salesforce as u on u.contactid = c.id
where
    u.IsActive = 1
    and pe.lumen__unRoll_Number__c is null
    and hed__Enrollment_Status__c = 'Active'
    and pe.id not in (
        select
            programenrollmentid
        from
            [All Program Enrollments]
    )