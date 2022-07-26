select
    distinct entityid as DiscussionForumId,
    entitytitle as ForumTitle,
    entitylink as ForumLink,
    startdate,
    enddate,
    courseofferingid,
    type,
    choice
from
    [LMS API Event Entry DE]
where
    entitytype = 'Discussion Forum'
    and action = 'Published'
    and entityid not in (
        select
            DiscussionForumId
        from
            [Discussion Forum Master Data]
    )
    and query = 'False'
    and recordcreateddate in (
        Select
            max(Recordcreateddate)
        from
            [LMS API Event Entry DE]
        group by
            entityid
    )