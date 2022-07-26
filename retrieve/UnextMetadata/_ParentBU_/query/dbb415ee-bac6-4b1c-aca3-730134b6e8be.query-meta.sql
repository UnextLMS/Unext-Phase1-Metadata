select
    newId,
    replace(phoneNumber, '-', '') as phoneNumber
from
    [Quiz Sendable]