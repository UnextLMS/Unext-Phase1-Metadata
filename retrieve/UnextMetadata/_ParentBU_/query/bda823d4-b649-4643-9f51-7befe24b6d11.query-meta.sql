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
                'case no',
                ' ',
                substring(s.messagetext, charindex('no', s.messagetext) + 2, 9),
                ' ',
                'has been reopened. Regards, Team Unext.'
            ) as Message,
            concat(
                'Case No',
                substring(s.messagetext, charindex('no', s.messagetext) + 2, 9),
                ' ',
                'Reopened'
            ) as Subject,
            concat(
                nc.[Case
: Contact: Id],
                    s.mobilemessagetrackingid,
                    'SMS'
                ) as SMSExternalid,
                s.mobilemessagetrackingid
                from
                    [SF Case
                        Reopening - 2022 -07 -15 T001305567] as nc
                        left join _smsmessagetracking as s on nc.[Case
: Contact: Id] = s.subscriberkey
                            where
                                name in ('Case Re-opening')
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