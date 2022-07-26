select
    distinct c.id as ContactID,
    c.email as emailaddress,
    c.phone as PhoneNumber,
    c.unContact_Name__c as Name,
    dfm.ForumLink,
    q.courseofferingid,
    q.entityId as DiscussionForumId,
    q.choice,
    q.type,
    concat(c.id, q.entityid) as uniqueid,
    'Published' as action,
    'IN' as Locale,
    dfm.StartDate,
    dfm.Enddate,
    dfm.ForumTitle as ForumTitle,
    ce.unCourse_Name__c as CourseName,
    q.groupid,
    concat(q.entityid, q.uniqueid, c.id, q.action) as NewId,
    'New Discussion Forum Published' as title,
    concat(
        'A new  Discussion Forum',
        ' ',
        dfm.ForumTitle,
        ' ',
        'has been published in your',
        ' ',
        ce.unCourse_Name__c,
        ' ',
        'which begins from',
        ' ',
        dfm.startdate,
        '.'
    ) as Body
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
    inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.id = q.groupid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.id
    inner join contact_Salesforce as c on c.id = ugm.unContact__c
where
    q.groupid is not null
    and q.Invalid = 'False'
    and q.entitytype = 'Discussion Forum'
    and c.id in (
        select
            hed__contact__c
        from
            HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe
        where
            pe.hed__Enrollment_Status__c = 'Active'
    )
    and q.query = 'False'
    and ug.unActive__c = 1
    and q.action in ('Published', 'Added')
    and concat(c.id, q.entityid) not in (
        select
            uniqueid
        from
            [Discussion Forum Unpublished]
    )
    and dfm.UnPublished = 'False'