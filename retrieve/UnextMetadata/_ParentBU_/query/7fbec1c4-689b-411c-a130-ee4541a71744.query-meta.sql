select
    distinct c.id as ContactID,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    c.phone as PhoneNumber,
    lumen__unContact_Name__c as Name,
    q.entityLink as ForumLink,
    q.courseofferingid,
    q.entityId as DiscussionForumId,
    u.id as UserId,
    concat(c.id, q.entityid) as uniqueid,
    q.choice,
    q.type,
    case
        when q.action = 'Thread Reply' then 'Thread Reply'
        when q.action = 'Report Published' then 'Report Published'
        when q.action = 'New Reply' then 'New Reply'
    end as action,
    case
        when q.action = 'Thread Reply' then 'New Reply to your Thread'
        when q.action = 'Report Published' then 'Discussion Forum Report Published'
        when q.action = 'New Reply' then 'New Reply to Your Question'
    end as Title,
    case
        when q.action = 'Thread Reply' then concat(
            q.ReplierName,
            ' ',
            'has replied to your thread in',
            dfm.forumTitle,
            ' ',
            'of',
            ' ',
            ce.lumen__unCourse_Name__c,
            '.'
        )
        when q.action = 'Report Published' then concat(
            'SDF/DCF',
            ' ',
            dfm.forumTitle,
            ' ',
            'report has been published in your',
            ' ',
            ce.lumen__unCourse_Name__c,
            '.'
        )
        when q.action = 'New Reply' then concat(
            q.ReplierName,
            ' ',
            'has replied to your question in',
            dfm.forumTitle,
            ' ',
            'of',
            ' ',
            ce.lumen__unCourse_Name__c,
            '.'
        )
    end as Body,
    'IN' as Locale,
    dfm.StartDate,
    dfm.Enddate,
    dfm.ForumTitle,
    ce.lumen__unCourse_Name__c as CourseName,
    q.ReplierName as RepliersName,
    concat(q.entityid, q.uniqueid, c.id, q.action) as NewId,
    q.Createddate,
    a.name as Program,
    a.ParentId as ParentId
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
    inner join contact_salesforce as c on c.id = q.Contactid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Contact__c = c.id
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    q.contactid is not null
    and q.entitytype = 'Discussion Forum'
    and c.id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and u.IsActive = 1
    and q.courseofferingid = ce.hed__Course_Offering__c
    and q.action in ('Thread Reply', 'Report Published', 'New Reply')