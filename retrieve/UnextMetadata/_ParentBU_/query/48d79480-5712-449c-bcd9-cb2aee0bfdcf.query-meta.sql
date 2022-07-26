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
    q.choice,
    q.type,
    concat(c.id, q.entityid) as uniqueid,
    case
        when q.action = 'Report Published' then 'Report Published'
    end as action,
    case
        when q.action = 'Report Published' then 'Discussion Forum Report Published'
    end as Title,
    case
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
    end as Body,
    'IN' as Locale,
    dfm.StartDate,
    dfm.Enddate,
    dfm.forumTitle,
    ce.lumen__unCourse_Name__c as CourseName,
    q.groupid,
    concat(q.entityid, q.uniqueid, c.id, q.action) as NewId,
    q.Createddate
from
    [LMS API Event Entry DE] as q
    inner join [Discussion Forum Master Data] as dfm on dfm.discussionforumid = q.entityid
    inner join lumen__unUser_Group__c_Salesforce as ug on ug.id = q.groupid
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = q.courseofferingid
    inner join lumen__unUser_Group_Member__c_Salesforce as ugm on ugm.lumen__unGroup__c = ug.id
    inner join contact_Salesforce as c on c.id = ugm.lumen__unContact__c
    left join user_Salesforce as u on u.ContactId = c.id
where
    q.groupid is not null
    and c.id in (
        select
            hed__contact__c
        from
            HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe
        where
            pe.hed__Enrollment_Status__c = 'Active'
    )
    and query = 'False'
    and ug.lumen__unActive__c = 1
    and u.IsActive = 1
    and q.action in ('Report Published')
    and q.entitytype = 'Discussion Forum'