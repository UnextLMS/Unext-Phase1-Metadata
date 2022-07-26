select
    a.contactid,
    a.mobile,
    a.subject,
    a.status,
    a.sent,
    a.smsexternalid,
    a.whatsappexternalid,
    a.message,
    a.sentdate,
    a.mobilemessagetrackingid
from
    (
        select
            contactid,
            mobile,
            subject,
            status,
            sent,
            smsexternalid,
            whatsappexternalid,
            message,
            sentdate,
            mobilemessagetrackingid,
            ROW_NUMBER() over (
                partition by mobilemessagetrackingid
                order by
                    mobilemessagetrackingid
            ) RowNumber
        from
            [Task Creation in SF All]
    ) a
where
    a.RowNumber = 1