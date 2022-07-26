select
    t.mobilemessagetrackingid,
    concat(
        'Hi',
        ' ',
        sf.[Case
: Contact: Name],
            ' ',
            sf.[Case
: CaseNumber],
                ' ',
                'has been created on your behalf. Regards Team Unext.'
            ) as Message,
            concat(
                'New',
                ' ',
                sf.[Case
: CaseNumber],
                    'Created'
                ) as Subject
                from
                    [Task Creation in SF] as t
                    inner join [SF New Case
                        Creation Trigger - 2022 -06 -09 T044123557] as sf on sf.[Case
: Contact: Id] = contactid
                            inner join _smsmessagetracking as s on s.mobilemessagetrackingid = t.mobilemessagetrackingid
                            and t.sent = 'False'