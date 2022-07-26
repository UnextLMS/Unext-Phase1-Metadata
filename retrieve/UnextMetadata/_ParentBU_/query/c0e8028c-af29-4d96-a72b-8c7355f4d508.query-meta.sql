select
    sent,
    delivered,
    undelivered,
    name,
    subscriberkey,
    mobilemessagetrackingid,
    mobile,
    actiondatetime,
    messagetext
from
    _smsmessagetracking
where
    mobile is not null
    and mobilemessagetrackingid is not null
    and ordinal = 0