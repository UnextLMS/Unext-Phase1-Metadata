select
    newid() as uniqueId,
    case
        when u.LastLoginDate is not null then datediff(day, u.LastLoginDate, getdate())
        when u.LastLoginDate is null then datediff(day, u.CreatedDate, getdate())
    end as [No Of Days],
    c.id as contactid,
    c.firstname,
    c.email as emailaddress,
    c.phone as phonenumber,
    u.LastLoginDate as [Last Login to Portal],
    u.CreatedDate as UserCreatedDate
from
    user_Salesforce as u
    inner join contact_salesforce as c on c.id = ContactId
where
    (
        datediff(day, LastLoginDate, getdate()) % 8 = 0
        or LastLoginDate is null
    )
    and contactid is not null
    and IsActive = 1