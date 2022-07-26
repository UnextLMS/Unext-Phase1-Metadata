select
    distinct c.contactid,
    c.id,
    c.CaseNumber as CaseNo,
    c.origin,
    c.status,
    c.lumen__unSub_Status__c as SubStatus,
    c.type,
    c.lumen__unResolution__c as Resolution,
    con.lumen__unContact_Name__c as Name,
    'IN' as Locale,
    u.id as UserId,
    con.phone as PhoneNumber,
    si.invitationlink as SurveyLink,
    c.lumen__unResolved_Date__c as ResolvedDate,
    'Case Resolved' as Title,
    concat(
        'Case',
        ' ',
        c.CaseNumber,
        ' ',
        'is resolved. Click here to check the resolution comments'
    ) as Body
from
    CASE_SALESFORCE as c
    inner join contact_Salesforce as con on con.id = c.contactid
    inner join user_salesforce as u on u.contactid = con.id
    inner join SURVEYSUBJECT_SALESFORCE as ss on ss.subjectid = c.id
    left join SURVEYINVITATION_SALESFORCE as si on si.id = ss.parentid
where
    c.status = 'Resolved'
    and datediff(minute, c.lumen__unResolved_Date__c, getdate()) <= 20