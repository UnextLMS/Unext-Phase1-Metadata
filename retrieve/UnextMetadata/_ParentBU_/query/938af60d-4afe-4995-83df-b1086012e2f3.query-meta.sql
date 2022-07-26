select
    s.programenrollmentid,
    s.contactid,
    case
        when datepart(weekday, dateadd(week, 1, startdate)) = datepart(weekday, getdate()) then 'Remainder1'
        when datepart(weekday, dateadd(week, 2, startdate)) = datepart(weekday, getdate()) then 'Remainder2'
        when datepart(weekday, dateadd(week, -1, enddate)) = datepart(weekday, getdate()) then 'Remainder3'
        when datepart(weekday, enddate) = datepart(weekday, getdate()) then 'Remainder4'
    end as Action
from
    [Semester Term Fee Due Sendable] as s
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.id = s.programenrollmentid
    inner join hed__Term__c_Salesforce as t on t.id = pe.Term__c
where
    pe.Term__c != t.id