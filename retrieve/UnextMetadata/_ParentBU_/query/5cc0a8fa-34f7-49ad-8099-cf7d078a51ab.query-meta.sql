select
    l.contactid,
    l.firstname,
    l.emailaddress,
    phonenumber,
    l.[Last Login to Portal],
    l.[No Of Days],
    l.CreatedDate,
    l.usercreateddate,
    l.uniqueId
from
    [Login SFDC Junction DE] as l