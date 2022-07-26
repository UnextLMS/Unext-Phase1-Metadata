select
    distinct asgs.contactId,
    asgs.assignmentId,
    case
        when asgs.uniqueId not IN (
            select
                concat(con.Id, assignmentId)
            from
                [Learner Assignment LMS] as asg
                inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = asg.courseOfferingId
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
    asg.startDate,
    asg.endDate,
    asgs.uniqueId
from
    [Learner Assignment Sendable] as asgs
    inner join [Learner Assignment LMS] as asg on asg.assignmentId = asgs.assignmentId
where
    asgs.action = 'Published'
    and asg.Target = 'All'