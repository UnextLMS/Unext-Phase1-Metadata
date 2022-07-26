select
    distinct entityId as assignmentId,
    entityTitle as assignmentTitle,
    entityLink as assignmentLink,
    startDate,
    endDate,
    type,
    courseOfferingId
from
    [LMS API Event Entry DE]
where
    entityType = 'Assignment'
    and action = 'Published'
    and entityId not in (
        select
            assignmentId
        from
            [Assignment Master Data]
    )
    and query = 'False'
    and recordcreateddate in (
        Select
            max(Recordcreateddate)
        from
            [LMS API Event Entry DE]
        group by
            entityid,
            entitytitle,
            startdate,
            enddate,
            courseofferingid
    )