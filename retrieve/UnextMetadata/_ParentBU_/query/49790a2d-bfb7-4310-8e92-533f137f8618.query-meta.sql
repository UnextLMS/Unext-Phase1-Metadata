select
    a.contactid,
    a.mobile,
    a.status,
    a.subject,
    a.SMSExternalId,
    a.WhatsappExternalId,
    a.mobilemessagetrackingid,
    a.sent,
    a.sentdate,
    a.message
from
    (
        select
            contactid,
            mobile,
            status,
            subject,
            SMSExternalId,
            WhatsappExternalId,
            mobilemessagetrackingid,
            sent,
            sentdate,
            message,
            ROW_NUMBER() over (
                partition by mobilemessagetrackingid
                order by
                    mobilemessagetrackingid
            ) Rownumber
        from
            [Task Creation in SF All]
    ) a
where
    a.rownumber = 1