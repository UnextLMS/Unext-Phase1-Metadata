select
    distinct nc.[Case
: Contact: Id] as ContactId,
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
            nc.[Case
: Contact: Name],
                ' ',
                'we need additonal information for your',
                ' ',
                'case no',
                ' ',
                substring(s.messagetext, charindex('no', s.messagetext) + 2, 9),
                ' ',
                'Please click here',
                ' ',
                nc.link,
                ' ',
                'to provide the input. Regards, Team Unext'
            ) as Message,
            concat(
                'Awating Student Input for Case No:',
                substring(s.messagetext, charindex('no', s.messagetext) + 2, 9)
            ) as Subject,
            concat(
                nc.[Case
: Contact: Id],
                    s.mobilemessagetrackingid,
                    'SMS'
                ) as SMSExternalid,
                concat(
                    nc.[Case
: Contact: Id],
                        s.mobilemessagetrackingid,
                        'Whatsapp'
                    ) as WhatsappExternalid,
                    s.mobilemessagetrackingid
                    from
                        [SF Awaiting Student Input - 2022 -06 -30 T074713798] as nc
                        left join _smsmessagetracking as s on nc.[Case
: Contact: Id] = s.subscriberkey
                            where
                                name = 'Awaiting Student Input reminder (days for reminder)'
                                and s.outbound = 1
                                and s.ordinal = 0
                                and s.mobilemessagetrackingid not in (
                                    Select
                                        mobilemessagetrackingid
                                    from
                                        [SMS Sendlog]
                                )
                                and mobile is not null
                                and [Case
: Contact: MobilePhone] is not null
                                    and mobilemessagetrackingid is not null