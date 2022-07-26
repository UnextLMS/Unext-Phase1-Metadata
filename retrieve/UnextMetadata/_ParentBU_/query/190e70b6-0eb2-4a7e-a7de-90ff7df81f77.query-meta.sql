select
    ug.unMentor1__c as Mentor1,
    ug.unMentor2__c as Mentor2,
    ug.Name as GroupName,
    ug.CreatedDate,
    ugm.unContact__c as ContactId,
    c.email as emailaddress,
    NewId() as UniqueId,
    c.firstname as firstname,
    u.FirstName as MentorName,
    u.Email as MentorEmail,
    ugm.Name as GroupMemberId
from
    UNUSER_GROUP__C_SALESFORCE as ug
    left join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.id
    left join User_Salesforce as u on u.id = ug.unMentor1__c
    or u.id = ug.unMentor2__c
    inner join contact_Salesforce as c on c.id = ugm.unContact__c
where
    ug.unMentor1__c is not null
    or ug.unMentor1__c is not null