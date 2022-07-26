select
    entityid,
    recordcreateddate
from
    [LMS API Event Entry DE]
where
    recordcreateddate > (
        select
            recordcreateddate
        from
            [LMS API Event Entry DE]
        where
            action = 'UnPublished'
    )
    and entityid = 'DFCC18010uat'