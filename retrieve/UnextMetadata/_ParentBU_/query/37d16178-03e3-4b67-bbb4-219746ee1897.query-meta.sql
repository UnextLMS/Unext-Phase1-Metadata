select
    a.contactid,
    a.uniqueid,
    a.name,
    a.action,
    a.parentid,
    a.program,
    a.title,
    a.body,
    a.forumtitle,
    a.forumlink,
    a.discussionforumid,
    a.userid,
    a.newid,
    a.coursename,
    a.courseofferingid,
    a.groupid,
    a.locale,
    a.emailaddress,
    a.phonenumber,
    a.startdate,
    a.enddate
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
            forumtitle,
            forumlink,
            discussionforumid,
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
            ROW_NUMBER() over (
                partition by uniqueid
                order by
                    uniqueid
            ) RowNumber
        from
            [Discussion Forum Temp Remainder]
    ) a
where
    a.RowNumber = 1