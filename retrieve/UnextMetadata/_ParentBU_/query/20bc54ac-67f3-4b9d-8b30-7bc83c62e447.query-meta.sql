select
    uniqueid,
    'True' as query
from
    [New Students Enrolled]
where
    (
        concat(contactid, courseofferingid) in (
            select
                concat(contactid, courseofferingid)
            from
                [Assignment Sendable]
        )
        or concat(contactid, courseofferingid) in (
            select
                concat(contactid, courseofferingid)
            from
                [Discussion Forum Sendable]
        )
        or concat(contactid, courseofferingid) in (
            select
                concat(contactid, courseofferingid)
            from
                [Live Classroom Sendable]
        )
        or concat(contactid, courseofferingid) in (
            select
                concat(contactid, courseofferingid)
            from
                [Quiz Sendable]
        )
        or concat(contactid, groupid) in (
            select
                concat(contactid, groupid)
            from
                [Assignment Sendable]
        )
        or concat(contactid, groupid) in (
            select
                concat(contactid, groupid)
            from
                [Discussion Forum Sendable]
        )
        or concat(contactid, groupid) in (
            select
                concat(contactid, groupid)
            from
                [Live Classroom Sendable]
        )
        or concat(contactid, groupid) in (
            select
                concat(contactid, groupid)
            from
                [Quiz Sendable]
        )
    )