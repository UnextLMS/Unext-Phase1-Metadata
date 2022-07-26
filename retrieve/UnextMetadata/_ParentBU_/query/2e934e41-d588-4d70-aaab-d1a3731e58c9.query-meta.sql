select
    uniqueid,
    action,
    contactid,
    groupid,
    target,
    case
        when concat(groupid, entityid) in (
            select
                concat(groupid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action in ('Invalid', 'Added')
                and groupid is not null
            group by
                concat(groupid, entityid)
            having
                count(*) % 2 = 0
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
        ) then 'Partial True'
        else 'False'
    end as Invalid,
    entityid,
    query,
    recordcreateddate
from
    [LMS API Event Entry DE]
where
    action in ('Published', 'Invalid', 'Added')
    and query = 'False'
    and entitytype = 'Assignment'
    and groupid is not null