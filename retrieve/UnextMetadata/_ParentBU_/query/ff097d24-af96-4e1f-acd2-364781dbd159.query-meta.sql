select
    distinct c.id as ContactID,
    case
        when c.unUniversity_Email__c is not null then c.unUniversity_Email__c
        else c.email
    end as emailaddress,
    case
        when len(unContact_Name__c) <= 30 then c.unContact_Name__c
        else concat(substring(c.unContact_Name__c, 1, 30), '...')
    end as smsname,
    case
        when len(dfm.forumTitle) <= 30 then dfm.forumTitle
        else concat(substring(dfm.forumTitle, 1, 30), '...')
    end as smsassignmentTitle,
    case
        when len(ce.unCourse_Name__c) <= 30 then ce.unCourse_Name__c
        else concat(substring(ce.unCourse_Name__c, 1, 30), '...')
    end as smscoursename,
    c.phone as PhoneNumber,
    concat(c.firstname, ' ', c.lastname) as Name,
    dfm.forumLink,
    q.courseofferingid,
    q.entityId,
    u.id as UserId,
    concat(c.id, q.entityid) as uniqueid,
    q.choice,
    q.type,
    'Remainder' as action,
    'IN' as Locale,
    dfm.StartDate,
    dfm.Enddate,
    dfm.ForumTitle,
    'Discussion Forum Remainder' as Title,
    concat(
        'Only 1 day left for Quiz',
        ' ',
        dfm.ForumTitle,
        ' ',
        'submission of',
        ' ',
        ce.unCourse_Name__c,
        ' ',
        'as deadline is',
        ' ',
        dfm.enddate,
        '.',
        ' ',
        'Please submit it before the',
        ' ',
        dfm.enddate
    ) as Body,
    concat(q.entityid, q.uniqueid, c.id, 'Remainder') as newid,
    ce.unCourse_Name__c as coursename,
    q.Groupid,
    dfm.discussionforumid
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
    inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.id = q.groupid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.id
    inner join contact_Salesforce as c on c.id = ugm.unContact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    datepart(day, dateadd(day, -1, dfm.enddate)) = datepart(day, GETUTCDATE())
    and c.id in (
        Select
            hed__Contact__c
        from
            hed__Program_Enrollment__c_Salesforce
        where
            hed__Enrollment_Status__c = 'Active'
    )
    and q.action in ('Published', 'Added')
    and q.groupid is not null
    and q.invalid = 'False'
    and dfm.UnPublished = 'False'
    and u.isactive = 1
    and q.entitytype = 'Discussion Forum'
    and ug.unActive__c = 1