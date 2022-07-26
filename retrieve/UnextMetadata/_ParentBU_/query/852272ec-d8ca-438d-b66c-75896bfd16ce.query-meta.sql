select
    distinct concat(c.id, q.discussionforumid) as uniqueid,
    q.discussionforumid,
    c.id,
    q.groupid
from
    [Discussion Forum LMS] as q
    inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.id = q.groupid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = ug.unCourse_Offering__c
    inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.id
    inner join contact_Salesforce as c on c.id = ugm.unContact__c
where
    action = 'Invalid'
    and query = 'False'
    and groupid is not null
    and c.id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )