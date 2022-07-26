select
    mobilemessagetrackingid,
    message,
    contactid as subscriberkey,
    sentdate as actiondatetime,
    mobile
from
    [Task Creation in SF]
where
    sent = 'False'