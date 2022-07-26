select
    entityId as liveClassroomId,
    entityTitle as liveClassroomTitle,
    entityLink as liveClassroomLink,
    startDate,
    endDate,
    choice,
    type,
    courseOfferingId
from
    [LMS API Event Entry DE]
where
    entitytype = 'Live Classroom'
    and action = 'Published'
    and entityId not IN (
        select
            liveClassroomId
        from
            [Live Classroom Master Data]
    )
    and query = 'False'
group by
    entityid,
    entitytitle,
    entitylink,
    startdate,
    enddate,
    courseofferingid,
    choice,
    type
having
    count(*) > 1
    or count(*) = 1