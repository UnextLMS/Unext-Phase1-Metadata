select
    programenrollmentid,
    a.name as Program,
    concat(
        'Your access to the ',
        ' ',
        a.name,
        ' ',
        'is enabled',
        ' ',
        'www.welcomelink.com'
    ) as Body
from
    [New User Enrollment SFDC] as dfs
    inner join HED__PROGRAM_ENROLLMENT__C_SALESFORCE as pe on pe.id = dfs.programenrollmentid
    inner join account_salesforce as a on a.id = pe.hed__account__c
where
    program is null