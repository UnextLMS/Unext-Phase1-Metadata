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
        when concat(groupid, entityid) in (
            select
                concat(groupid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Invalid'
                and groupid is not null
            group by
                concat(groupid, entityid)
            having
                count(*) = 1
        )
        and concat(groupid, entityid) in (
            select
                concat(groupid, entityid)
            from
                [LMS API Event Entry DE]
            where
                action = 'Published'
                and groupid is not null
            group by
                concat(groupid, entityid)
            having
                count(*) = 1
        ) then 'True'
        else 'False'
    end as Invalid,
    entityid,
    query,
    recordcreateddate
from
    [LMS API Event Entry DE] as lms
where
    action in ('Published', 'Invalid', 'Added')
    and entitytype = 'Assignment'
    and groupid is not null