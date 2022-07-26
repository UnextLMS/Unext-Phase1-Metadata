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
        when q.action = 'Report Published' then 'Report Published'
    end as action,
    case
        when q.action = 'Report Published' then concat(
            'SDF/DCF',
            ' ',
            dfm.ForumTitle,
            ' ',
            'report has been published in your',
            ' ',
            ce.lumen__unCourse_Name__c,
            '.'
        )
    end as Body,
    case
        when q.action = 'Report Published' then 'Discussion Forum Report Published'
    end as Title,
    'IN' as Locale,
    dfm.StartDate,
    dfm.Enddate,
    dfm.forumTitle,
    ce.lumen__unCourse_Name__c as CourseName,
    concat(q.entityid, q.uniqueid, c.id, q.action) as NewId,
    q.Createddate,
    a.name as Program,
    a.ParentId as ParentId
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join account_Salesforce as a on a.id = ce.hed__Account__c
    inner join contact_salesforce as c on c.id = ce.hed__Contact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    Target = 'All'
    and q.entitytype = 'Discussion Forum'
    and c.id in (
        Select
            hed__contact__c
        from
            HED__PROGRAM_ENROLLMENT__C_SALESFORCE
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and u.IsActive = 1
    and q.action = 'Report Published'