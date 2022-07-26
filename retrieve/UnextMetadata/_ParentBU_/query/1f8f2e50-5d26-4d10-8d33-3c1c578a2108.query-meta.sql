select
    'False' as Invalid,
    UniqueId
from
    [LMS API Event Entry DE]
where
    action = 'Added'
    and query = 'False'
    and entitytype = 'Assignment'
    and recordcreateddate in (
        Select
            max(Recordcreateddate)
        from
            [LMS API Event Entry DE]
        where
            action = 'Added'
            and query = 'False'
            and entitytype = 'Assignment'
    )