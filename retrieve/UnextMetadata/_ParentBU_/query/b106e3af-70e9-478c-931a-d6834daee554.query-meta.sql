select
    groupid,
    target,
    courseofferingid,
    contactid,
    entityid as AssignmentId
from
    [LMS API Event Entry DE]
where
    entitytype = 'Assignment'
    and [action] in ('Added', 'Invalid')
    and query = 'True'
    and (
        concat(groupid, entityid) not in (
            select
                concat(groupid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action in ('Added', 'Invalid')
                and query = 'False'
        )
        or concat(contactid, entityid) not in (
            select
                concat(contactid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action in ('Added', 'Invalid')
                and query = 'False'
        )
        or concat('All', entityid) not in (
            select
                concat('All', entityid)
            from
                [LMS API Event Entry DE]
            where
                action in ('Added', 'Invalid')
                and query = 'False'
        )
    )