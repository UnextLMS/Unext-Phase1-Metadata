select
    [Case
: Id] as Id,
        [Case
: CaseNumber] as CaseNo,
            [Case
: Origin] as Origin,
                [Case
: ContactMobile] as PhoneNumber,
                    [Case
: unResolution__c] as Resolution,
                        [Case
: Status] as Status,
                            [Case
: unSub_Status__c] as Substatus,
                                [Case
: Contact: Id] as ContactId,
                                    [Case
: Contact: unContact_Name__c] as Name,
                                        [Case
: Contact: User__c] as UserId,
                                            'IN' as Locale,
                                            [Case
: unResolved_Date__c] as ResolvedDate,
                                                [Case
: Type] as Type,
                                                    si.invitationlink as SurveyLink
                                                    from
                                                        [SF Case
                                                            Resolution - 2022 -05 -25 T232932340]
                                                            inner join SURVEYSUBJECT_SALESFORCE as ss on ss.subjectid = [Case
: Id]
                                                                left join SURVEYINVITATION_SALESFORCE as si on si.id = ss.parentid
                                                                where
                                                                    [Case
: Status] = 'Resolved'
                                                                        and datediff(
                                                                            minute,
                                                                            [Case
: unResolved_Date__c],
                                                                                getdate()
                                                                            ) <= 20
                                                                            and datediff(minute, si.createddate, getdate()) <= 20