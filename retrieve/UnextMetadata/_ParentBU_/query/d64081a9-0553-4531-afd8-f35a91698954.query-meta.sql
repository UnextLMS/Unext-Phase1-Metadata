select
    distinct c.id as ContactID,
    case
        when c.lumen__unUniversity_Email__c is not null then c.lumen__unUniversity_Email__c
        else c.email
    end as emailaddress,
    c.phone as PhoneNumber,
    c.lumen__unContact_Name__c as Name,
    dfm.ForumLink,
    q.courseofferingid,
    q.entityId as DiscussionForumId,
    u.id as UserId,
    q.choice,
    q.type,
    concat(c.id, q.entityid) as uniqueid,
    'Published' as action,
    'IN' as Locale,
    dfm.StartDate,
    dfm.Enddate,
    dfm.ForumTitle,
    ce.lumen__unCourse_Name__c as CourseName,
    concat(q.entityid, q.uniqueid, c.id, q.action) as NewId,
    q.CreatedDate,
    a.name as Program,
    a.ParentId as ParentId,
    'New Discussion Forum Published' as title,
    concat(
        'A new  Discussion Forum',
        ' ',
        dfm.ForumTitle,
        ' ',
        'has been published in your',
        ' ',
        ce.lumen__unCourse_Name__c,
        ' ',
        'which begins from',
        ' ',
        dfm.startdate,
        '.'
    ) as Body,
    case
        when action = 'Published' then 'Send'
        when action = 'Added'
        and dfm.unpublished = 'False' then 'Send'
        when q.action = 'Added'
        and dfm.unpublished = 'True' then 'Dont Send'
    end as Journeyaction
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
    and u.IsActive = 1
    and query = 'False'
    and q.courseofferingid = ce.hed__Course_Offering__c
    and q.action in ('Published', 'Added')
    and concat(c.id, q.entityid) not in (
        select
            uniqueid
        from
            [Discussion Forum Unpublished]
    )