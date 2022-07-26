select
    uniqueid,
    action,
    contactid,
    groupid,
    target,
    entityid,
    case
        when concat('All', entityid) in (
            select
                concat('All', entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and query = 'False'
        )
        or concat(groupid, entityid, uniqueid) in (
            select
                concat(groupid, entityid, uniqueid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and query = 'False'
        )
        or concat(contactid, entityid) in (
            select
                concat(contactid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and query = 'False'
        ) then 'True'
        when concat('All', entityid) not in (
            select
                concat('All', entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and query = 'False'
        )
        or concat(groupid, entityid, uniqueid) not in (
            select
                concat(groupid, entityid, uniqueid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and query = 'False'
        )
        or concat(contactid, entityid) not in (
            select
                concat(contactid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and query = 'False'
        ) then 'False'
    end as invalid
from
    [LMS API Event Entry DE]
where
    action in ('Invalid', 'Added', 'Published')
    and entitytype = 'Assignment'
    and query = 'False'