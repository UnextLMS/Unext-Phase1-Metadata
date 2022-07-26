select
    lms.uniqueId,
    lms.action,
    lms.target,
    lms.contactId,
    lms.groupId,
    case
        when concat(contactid, entityid) in (
            select
                concat(contactid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action in ('Invalid', 'Added')
                and contactid is not null
            group by
                concat(contactid, entityid)
            having
                count(*) % 2 = 0
        )
        and concat(groupid, entityid) not in (
            select
                concat(groupid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action in ('Published')
                and groupid is not null
        ) then 'True'
        when concat(contactid, entityid) in (
            select
                concat(contactid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and contactid is not null
            group by
                concat(contactid, entityid)
            having
                count(*) = 1
        )
        and concat(contactid, entityid) in (
            select
                concat(contactid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Published'
                and contactid is not null
            group by
                concat(contactid, entityid)
            having
                count(*) = 1
        ) then 'True'
        else 'False'
    end as Invalid
from
    [LMS API Event Entry DE] as lms
where
    lms.action in ('Published', 'Invalid', 'Added')
    and lms.entitytype = 'Live Classroom'
    and lms.contactid is not null