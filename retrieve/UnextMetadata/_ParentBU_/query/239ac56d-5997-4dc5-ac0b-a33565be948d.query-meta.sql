select
    uniqueId,
    assignmentId,
    contactId
from
    [Assignment Sendable]
where
    newUser = 'True'
    and sentStatus = 'False'
    and uniqueId not IN (
        Select
            uniqueId
        from
            [Assignment New Users]
    )