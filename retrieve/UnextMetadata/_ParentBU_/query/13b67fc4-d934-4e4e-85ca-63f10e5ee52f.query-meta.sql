select
    distinct nc.contactid as ContactId,
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
        nc.Fullname,
        ' ',
        'Your access to',
        ' ',
        substring(s.messagetext, charindex('to', s.messagetext) + 2, 4),
        ' ',
        'is confirmed. We have shared the details on',
        ' ',
        nc.personalemail,
        ' ',
        'Please check email from Unext for details. Regards Team Unext'
    ) as Message,
    'New User Enrollment' as Subject,
    concat(nc.ContactId, s.mobilemessagetrackingid, 'SMS') as SMSExternalid,
    concat(
        nc.ContactId,
        s.mobilemessagetrackingid,
        'Whatsapp'
    ) as WhatsappExternalid,
    s.mobilemessagetrackingid
from
    [New User Enrollment SFDC] as nc
    left join _smsmessagetracking as s on nc.contactid = s.subscriberkey
where
    name in ('New User Enrollment Text')
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