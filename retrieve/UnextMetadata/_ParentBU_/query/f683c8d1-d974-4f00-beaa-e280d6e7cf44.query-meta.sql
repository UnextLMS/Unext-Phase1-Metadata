select
    lastlogindate,
    contactid,
    id,
    name
from
    User_Salesforce
where
    contactid is not null
    and lastlogindate is not null