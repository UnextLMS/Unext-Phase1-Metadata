select
    distinct ns.contactid,
    ns.groupid,
    ns.emailaddress,
    ns.PhoneNumber,
    ns.UserId,
    ns.Name,
    ns.Program,
    q.Action,
    q.groupid as lmsgroup,
    q.entityid as discussionforum,
    dfm.forumLink,
    dfm.choice,
    dfm.type,
    dfm.StartDate,
    dfm.Enddate,
    dfm.forumTitle,
    concat(
        dfm.discussionforumid,
        ns.GroupId,
        ns.contactid,
        'NewUser'
    ) as NewId,
    ce.hed__Course_Offering__c as courseofferingid,
    ce.lumen__unCourse_Name__c as CourseName,
    'True' as NewUser,
    dfm.discussionforumid,
    concat(ns.contactid, dfm.discussionforumid) as Uniqueid,
    ns.programid,
    ns.parentid,
    'IN' as Locale,
    'New Discussion Forum Published' as title,
    concat(
        'A new  Discussion Forum',
        ' ',
        dfm.ForumTitle,
        ' ',
        'has been published in your',
        ' ',
        ns.CourseName,
        ' ',
        'which begins from',
        ' ',
        dfm.startdate,
        '.'
    ) as Body
from
    [New Students Enrolled] as ns
    inner join [LMS API Event Entry DE] as q on q.groupid = ns.groupid
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = dfm.courseofferingid
where
    ns.groupid is not null
    and dfm.unpublished = 'False'
    and ns.query = 'False'
    and q.entitytype = 'Discussion Forum'