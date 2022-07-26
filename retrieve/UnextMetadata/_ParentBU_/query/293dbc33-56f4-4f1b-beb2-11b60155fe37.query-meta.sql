select
    distinct lcs.contactId,
    lcs.liveClassroomId,
    case
        when lcs.uniqueId not IN (
            select
                concat(con.Id, liveClassroomId)
            from
                [Learner Live Classroom LMS] as lc
                inner join UNUSER_GROUP__C_SALESFORCE as ug on ug.Id = lc.groupId
                inner join UNUSER_GROUP_MEMBER__C_SALESFORCE as ugm on ugm.unGroup__c = ug.Id
                inner join contact_Salesforce as con on con.Id = ugm.unContact__c
            where
                action = 'Published'
                and query = 'False'
                and groupId is not null
        ) then 'True'
        else 'False'
    end as Invalid,
    newId,
    lc.startDate,
    lc.startTime
from
    [Learner Live Classroom Sendable] as lcs
    inner join [Learner Live Classroom LMS] as lc on lc.liveClassroomId = lcs.liveClassroomId
where
    lcs.action = 'Published'
    and lc.groupId is not null