select
    a.contactid,
    a.uniqueid,
    a.name,
    a.action,
    a.parentid,
    a.program,
    a.title,
    a.body,
    a.quiztitle,
    a.quizlink,
    a.quizid,
    a.userid,
    a.newid,
    a.coursename,
    a.courseofferingid,
    a.groupid,
    a.locale,
    a.emailaddress,
    a.phonenumber,
    a.startdate,
    a.enddate,
    a.smsname,
    a.smsquiztitle,
    a.smscoursename,
    a.message
from
    (
        select
            contactid,
            uniqueid,
            name,
            action,
            parentid,
            program,
            title,
            body,
            quiztitle,
            quizlink,
            quizid,
            userid,
            newid,
            coursename,
            courseofferingid,
            groupid,
            locale,
            emailaddress,
            phonenumber,
            startdate,
            enddate,
            smsname,
            smsquiztitle,
            smscoursename,
            message,
            ROW_NUMBER() over (
                partition by uniqueid
                order by
                    uniqueid
            ) RowNumber
        from
            [Quiz Temp Remainder]
    ) a
where
    a.RowNumber = 1