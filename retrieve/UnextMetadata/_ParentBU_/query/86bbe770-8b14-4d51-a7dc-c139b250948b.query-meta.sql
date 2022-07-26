select
    distinct nc.contactid as ContactId,
    mobile,
    actiondatetime as sentdate,
    case
        when s.delivered = 1 then 'Delivered'
        when s.undelivered = 1 then 'Not Sent'
        else 'Sent'
    end as Status,
    nc.message,
    concat(nc.quiztitle, 'Quiz Remainder') as Subject,
    concat(nc.ContactId, s.mobilemessagetrackingid, 'SMS') as SMSExternalid,
    concat(
        nc.ContactId,
        s.mobilemessagetrackingid,
        'Whatsapp'
    ) as WhatsappExternalid,
    s.mobilemessagetrackingid
from
    [Quiz Sendable] as nc
    left join _smsmessagetracking as s on nc.contactid = s.subscriberkey
where
    s.name in ('Quiz Rem3')
    and s.outbound = 1
    and s.ordinal = 0
    and s.mobilemessagetrackingid not in (
        Select
            mobilemessagetrackingid
        from
            [SMS Sendlog]
    )
    and mobile is not null
    and mobilemessagetrackingid is not null