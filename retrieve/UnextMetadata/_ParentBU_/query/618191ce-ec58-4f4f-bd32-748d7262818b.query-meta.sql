select
    distinct nc.contactid as ContactId,
    mobile,
    actiondatetime as sentdate,
    case
        when s.delivered = 1 then 'Delivered'
        when s.undelivered = 1 then 'Not Sent'
        else 'Sent'
    end as Status,
    concat(
        'Dear',
        ' ',
        nc.name,
        ' ',
        'Hurry Up! Only 1 day left for Assignment',
        ' ',
        nc.assignmentTitle,
        ' ',
        'submission of',
        ' ',
        nc.courseName,
        ' ',
        'as deadline is',
        ' ',
        nc.enddate,
        ' ',
        'Use this opportunity & submit the assignment in LMS immediately to avoid the last minute rush.If you do not submit the assignment on/before cut-off date, you will be marked as ABSENT in IA and will be allowed to submit fresh assignments for next session after applying for re- sitting with fees.Please click here',
        ' ',
        nc.assignmentLink,
        ' ',
        'to attempt it now.Please ignore if already attempted Regards,Team MUJ'
    ) as Message,
    concat(nc.assignmenttitle, 'Assignment Remainder') as Subject,
    concat(nc.ContactId, s.mobilemessagetrackingid, 'SMS') as SMSExternalid,
    concat(
        nc.ContactId,
        s.mobilemessagetrackingid,
        'Whatsapp'
    ) as WhatsappExternalid,
    s.mobilemessagetrackingid
from
    [Assignment Sendable] as nc
    left join _smsmessagetracking as s on nc.contactid = s.subscriberkey
where
    s.name in ('Assignment Rem')
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