select
    distinct lcs.contactId,
    lcs.liveClassroomId,
    case
        when lcs.uniqueId not IN (
            select
                concat(con.Id, liveClassroomId)
            from
                [Learner Live Classroom LMS] as lc
                inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = lc.courseOfferingId
                inner join contact_salesforce as con on con.Id = ce.hed__Contact__c
                left join user_Salesforce as u on u.contactId = con.Id
            where
                action = 'Published'
                and query = 'False'
                and Target = 'All'
        ) then 'True'
        else 'False'
    end as Invalid,
    newId,
    lc.startDate,
    lc.startTime,
    lcs.uniqueId
from
    [Learner Live Classroom Sendable] as lcs
    inner join [Learner Live Classroom LMS] as lc on lc.liveClassroomId = lcs.liveClassroomId
where
    lcs.action = 'Published'
    and lc.Target = 'All'