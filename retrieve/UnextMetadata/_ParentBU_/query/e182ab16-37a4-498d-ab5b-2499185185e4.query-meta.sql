select
    sent,
    delivered,
    undelivered,
    name,
    messagetext,
    subscriberkey,
    sendjobid,
    mobilemessagetrackingid,
    actiondatetime,
    mobile,
    outbound,
    inbound,
    sharedkeyword,
    fromname,
    ordinal,
    JBDefinitionID
from
    _smsmessagetracking
where
    mobile is not null
    and mobilemessagetrackingid is not null
    and ordinal = 0