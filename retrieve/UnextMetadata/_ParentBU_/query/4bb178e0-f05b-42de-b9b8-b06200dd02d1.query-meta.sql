select
    newid() as uniqueId,
    case
        when u.LastLoginDate is not null then datediff(day, u.LastLoginDate, GETUTCDATE())
        when u.LastLoginDate is null then datediff(day, u.CreatedDate, GETUTCDATE())
    end as [No Of Days],
    c.id as contactid,
    c.firstname,
    c.email as emailaddress,
    c.phone as phonenumber,
    u.LastLoginDate as [Last Login to Portal],
    u.CreatedDate as UserCreatedDate,
    u.id as userid
from
    user_Salesforce as u
    inner join contact_salesforce as c on c.id = ContactId
where
    (
        datediff(day, LastLoginDate, GETUTCDATE()) % 8 = 0
        or LastLoginDate is not null
    )
    and contactid is not null
    and IsActive = 1