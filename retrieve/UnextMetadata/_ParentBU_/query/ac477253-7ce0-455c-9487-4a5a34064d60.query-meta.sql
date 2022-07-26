select
    entityId as quizId,
    entityTitle as quizTitle,
    entityLink as quizLink,
    startDate,
    endDate,
    type,
    courseOfferingId
from
    [LMS API Event Entry DE]
where
    entityType = 'Quiz'
    and action = 'Published'
    and entityId not in (
        select
            quizId
        from
            [Quiz Master Data]
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