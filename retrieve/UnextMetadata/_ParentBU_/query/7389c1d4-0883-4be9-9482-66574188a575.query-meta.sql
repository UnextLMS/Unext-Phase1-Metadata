select
    [Case
: Contact: Id] as contactid,
        sf.[Case
: Contact: MobilePhone] as Mobile,
            [case
: Casenumber] as casenumber,
                s.subscriberkey,
                s.createdatetime as sentdate,
                s.mobilemessagetrackingid,
                concat(
                    'Hi',
                    ' ',
                    sf.[Case
: Contact: Name],
                        ' ',
                        'case no',
                        ' ',
                        sf.[Case
: CaseNumber],
                            ' ',
                            'has been Created on your behalf. Regards, Team Unext.'
                        ) as Message
                        from
                            [SF New Case
                                Creation Phase1 - 2022 -06 -30 T071024530] as sf
                                inner join (
                                    select
                                        subscriberkey,
                                        createdatetime,
                                        mobilemessagetrackingid
                                    from
                                        _smsmessagetracking
                                    group by
                                        subscriberkey,
                                        createdatetime,
                                        mobilemessagetrackingid
                                ) as s on s.subscriberkey = sf.[Case
: Contact: Id]