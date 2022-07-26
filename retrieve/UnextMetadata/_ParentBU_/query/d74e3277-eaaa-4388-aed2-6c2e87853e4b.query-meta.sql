select
    a.contactid,
    a.uniqueid,
    a.name,
    a.action,
    a.parentid,
    a.program,
    a.title,
    a.body,
    a.assignmentTitle,
    a.assignmentLink,
    a.assignmentid,
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
    a.smsassignmenttitle,
    a.smscoursename
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
            assignmentTitle,
            assignmentLink,
            assignmentId,
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
            smsassignmenttitle,
            smscoursename,
            ROW_NUMBER() over (
                partition by uniqueid
                order by
                    uniqueid
            ) RowNumber
        from
            [Assignment Temp Remainder]
    ) a
where
    a.RowNumber = 1