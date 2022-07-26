select
    distinct entityId as qaId,
    entityTitle as qaTitle,
    entityLink as qaLink,
    startDate,
    endDate,
    choice,
    type,
    courseOfferingId
from
    [LMS API Event Entry DE]
where
    entityType = 'Q&A'
    and action = 'New Reply'
    and entityId not IN (
        select
            qaId
        from
            [QA Master Data]
    )
    and query = 'False'