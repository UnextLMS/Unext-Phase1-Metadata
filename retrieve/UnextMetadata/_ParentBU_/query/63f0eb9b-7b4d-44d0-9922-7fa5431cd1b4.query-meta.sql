select
    unMentor1__c as Mentor1,
    unMentor2__c as Mentor2,
    ug.Name as GroupName,
    ug.CreatedDate,
    unContact__c as ContactId,
    c.email as emailaddress,
    c.Email as EmailId,
    c.Phone as MobileNo,
    NewId() as UniqueId,
    c.firstname as firstname,
    u.Name as MentorName,
    u.Email as MentorEmail,
    ugm.Name as GroupMemberId
from
    unUser_Group__c_Salesforce as ug
    left join unUser_Group_Member__c_Salesforce as ugm on unGroup__c = ug.id
    left join User_Salesforce as u on u.id = unMentor1__c
    or u.id = unMentor2__c
    inner join contact_Salesforce as c on c.id = ugm.unContact__c
where
    unMentor1__c is not null