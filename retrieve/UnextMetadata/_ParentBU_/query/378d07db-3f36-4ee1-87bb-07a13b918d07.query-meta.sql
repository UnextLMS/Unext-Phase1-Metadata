select
    [Case
: Id] as caseid,
        [Case
: CaseNumber] as CaseNumber,
            [Case
: Contact: Id] as ContactId,
                [Case
: Contact: lumen__unContact_Name__c] as Name,
                    [Case
: Contact: Email] as emailaddress,
                        [Case
: Contact: MobilePhone] as phonenumber,
                            [Case
: Contact: lumen__User__c] as userid,
                                concat(
                                    'https://lumen-u-next.force.com/StudentPortal/s/case/',
                                    [Case
: Id],
                                        '/'
                                    ) as link
                                    from
                                        [SF Awaiting Student Input - 2022 -07 -15 T000906062]
                                    where
                                        query = 'False'