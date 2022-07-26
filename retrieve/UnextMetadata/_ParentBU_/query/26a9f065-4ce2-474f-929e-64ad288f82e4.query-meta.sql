select
    uniqueId,
    liveClassroomId,
    contactId
from
    [Live Classroom Sendable]
where
    newUser = 'True'
    and sentStatus = 'False'
    and uniqueId not IN (
        Select
            uniqueId
        from
            [Live Classroom New Users]
    )