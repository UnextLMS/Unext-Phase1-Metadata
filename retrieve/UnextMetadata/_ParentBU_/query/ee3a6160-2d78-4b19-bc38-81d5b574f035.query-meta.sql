select
    contactid,
    t.mobile,
    case
        when s.delivered = 1 then 'Delivered'
        when s.undelivered = 1 then 'Not Sent'
        else 'Sent'
    end as Status,
    smsexternalid,
    message,
    subject,
    sentdate,
    s.mobilemessagetrackingid
from
    [Task Creation in SF] as t
    left join _smsmessagetracking as s on t.mobilemessagetrackingid = s.mobilemessagetrackingid
where
    t.status in ('Sent', 'Not Sent')