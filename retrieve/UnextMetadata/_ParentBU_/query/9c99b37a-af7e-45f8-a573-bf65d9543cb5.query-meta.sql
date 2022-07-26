select
    uniqueId,
    quizId,
    contactId
from
    [Quiz Sendable]
where
    newUser = 'True'
    and sentStatus = 'False'
    and uniqueId not IN (
        Select
            uniqueId
        from
            [Quiz New Users]
    )