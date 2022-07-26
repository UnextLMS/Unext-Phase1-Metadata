select
    uniqueid,
    action,
    contactid,
    groupid,
    target,
    case
        when concat('All', entityid) in (
            select
                concat('All', entityid)
            from
                [LMS API Event Entry DE]
            where
                action in ('Invalid', 'Added')
                and target = 'All'
            group by
                concat('All', entityid)
            having
                count(*) % 2 = 0
        ) then 'True'
        when concat('All', entityid) not in (
            select
                concat('All', entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and target = 'All'
            group by
                concat('All', entityid)
            having
                count(*) % 2 = 0
        ) then 'True'
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
    and target = 'All'