select
    distinct nc.ContactId,
    mobile,
    createdatetime as sentdate,
    case
        when s.delivered = 1 then 'Delivered'
        when s.undelivered = 1 then 'Not Sent'
        else 'Sent'
    end as Status,
    concat(
        'Hi',
        ' ',
        nc.name,
        ' ',
        substring(s.messagetext, charindex('no', s.messagetext) + 2, 9),
        ' ',
        'has been marked as resolved. Please check email for details. Feedback link -',
        nc.surveylink
    ) as Message,
    concat(
        'Case No',
        substring(s.messagetext, charindex('no', s.messagetext) + 2, 9),
        ' ',
        'Resolved'
    ) as Subject,
    concat(nc.ContactId, s.mobilemessagetrackingid, 'SMS') as SMSExternalId,
    concat(
        nc.ContactId,
        s.mobilemessagetrackingid,
        'Whatsapp'
    ) as WhatsappExternalId,
    s.mobilemessagetrackingid
from
    [SF Case
        Resolution] as nc
        left join _smsmessagetracking as s on nc.ContactId = s.subscriberkey
        where
            s.name in ('SF Case Resolution')
            and s.outbound = 1
            and s.ordinal = 0
            and mobile is not null
            and mobilemessagetrackingid is not null
            and phonenumber is not null
            and s.mobilemessagetrackingid not in (
                Select
                    mobilemessagetrackingid
                from
                    [SMS Sendlog]
            )