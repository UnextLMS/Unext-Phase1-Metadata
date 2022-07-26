select
    distinct nc.[Case
: Contact: Id] as contactid,
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
                'case no',
                ' ',
                substring(s.messagetext, charindex('no', s.messagetext) + 2, 9),
                ' ',
                'has been Opened on your behalf. Regards, Team UNext.'
            ) as Message,
            concat(
                'New Case',
                substring(s.messagetext, charindex('no', s.messagetext) + 2, 9),
                ' ',
                'Created'
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
                        [SF New Case
                            Creation Phase1 - 2022 -07 -15 T000623028] as nc
                            inner join _smsmessagetracking as s on nc.[Case
: Contact: Id] = s.subscriberkey
                                where
                                    name = 'New Case Creation'
                                    and s.outbound = 1
                                    and s.ordinal = 0
                                    and mobile is not null
                                    and mobilemessagetrackingid is not null
                                    and [Case
: Contact: MobilePhone] is not null
                                        and s.mobilemessagetrackingid not in (
                                            Select
                                                MobileMessageTrackingID
                                            from
                                                [SMS Sendlog]
                                        )