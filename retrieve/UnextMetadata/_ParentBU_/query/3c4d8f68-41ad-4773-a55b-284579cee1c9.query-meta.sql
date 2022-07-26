Select
    Id as contactId,
    'IN' as Locale,
    replace(phone, '-', '') as PhoneNumber,
    newId() as newId
from
    contact_salesforce