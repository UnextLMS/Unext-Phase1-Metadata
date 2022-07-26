select
    uniqueid,
    discussionforumid,
    contactid
from
    [Discussion Forum Sendable]
where
    Newuser = 'True'
    and sent = 'False'
    and uniqueid not in (
        Select
            uniqueid
        from
            [Discussion Forum New Users]
    )