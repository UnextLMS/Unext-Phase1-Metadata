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
    concat(c.id, q.entityid) as uniqueid,
    q.choice,
    q.type,
    'Published' as action,
    'IN' as Locale,
    dfm.StartDate,
    dfm.Enddate,
    dfm.ForumTitle,
    ce.lumen__unCourse_Name__c as CourseName,
    concat(q.entityid, q.uniqueid, c.id, q.action) as NewId,
    q.Createddate,
    a.name as Program,
    a.parentid as Parentid,
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
        when q.action = 'Published' then 'Send'
        when q.action = 'Added'
        and dfm.unpublished = 'False' then 'Send'
        when q.action = 'Added'
        and dfm.unpublished = 'True' then 'Dont Send'
    end as Journeyaction
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
    and q.query = 'False'
    and u.Isactive = 1
    and concat(c.id, q.entityid) not in (
        select
            uniqueid
        from
            [Discussion Forum Unpublished]
    )
    and q.action in ('Published', 'Added')