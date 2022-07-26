select
    distinct s.subscriberkey,
    s.emailaddress,
    j.FromEmail,
    j.EmailName,
    j.EmailSubject,
    case
        when o.eventdate is not null then concat('Last Opened', ' ', o.eventdate)
        else 'Sent'
    end as Status,
    'Hi Mohamed quiz is created complete the quiz on time' as EmailBody
from
    _subscribers as s
    inner join _sent as se on se.subscriberkey = s.subscriberkey
    inner join _open as o on o.subscriberkey = s.SubscriberKey
    inner join _job as j on j.jobid = o.jobid