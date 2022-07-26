select
    distinct ns.contactid,
    ns.courseofferingid,
    ns.emailaddress,
    ns.PhoneNumber,
    ns.UserId,
    ns.Program,
    ns.Name,
    ns.CourseName,
    concat(
        dfm.discussionforumid,
        ns.UserId,
        ns.contactid,
        'NewUser'
    ) as NewId,
    dfm.ForumLink,
    dfm.choice,
    dfm.type,
    dfm.StartDate,
    dfm.Enddate,
    dfm.ForumTitle,
    'True' as NewUser,
    'NewUser' as Action,
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
    inner join [Discussion Forum Master Data] as dfm on dfm.courseofferingid = ns.courseofferingid
where
    ns.query = 'False'
    and dfm.unpublished = 'False'
    and ns.groupid = ''