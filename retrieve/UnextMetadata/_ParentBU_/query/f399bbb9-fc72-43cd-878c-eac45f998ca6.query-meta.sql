select
    l.contactid,
    l.firstname,
    l.emailaddress,
    phonenumber,
    l.[Last Login to Portal],
    l.[No Of Days],
    l.CreatedDate,
    l.usercreateddate,
    UniqueId as UniqueId
from
    [Login SFDC] as l
    inner join user_salesforce as c on c.contactid = l.contactid
where
    c.LastLoginDate is null
    and datediff(day, l.CreatedDate, getdate()) % 8 = 0
    and sent = 'True'