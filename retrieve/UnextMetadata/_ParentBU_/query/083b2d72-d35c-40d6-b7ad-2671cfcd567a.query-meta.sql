select
    case
        when dfm.discussionforumid in (
            select
                lms.entityid
            from
                [LMS API Event Entry DE] as lms
                inner join [LMS API Event Entry DE] as lms1 on lms1.entityid = lms.entityid
            where
                lms.action = 'Published'
                and lms1.action = 'Unpublished'
                and lms1.recordcreateddate > lms.recordcreateddate
                and lms1.recordcreateddate in (
                    Select
                        top 1 recordcreateddate
                    from
                        [LMS API Event Entry DE] as lms2
                    where
                        action = 'UnPublished'
                        and lms2.entityid = lms1.entityid
                    order by
                        recordcreateddate desc
                )
        )
        and dfm.discussionforumid not in (
            select
                lms.entityid
            from
                [LMS API Event Entry DE] as lms
                inner join [LMS API Event Entry DE] as lms1 on lms1.entityid = lms.entityid
            where
                lms.action = 'Published'
                and lms1.action = 'Unpublished'
                and lms1.recordcreateddate < lms.recordcreateddate
                and lms1.recordcreateddate in (
                    Select
                        top 1 recordcreateddate
                    from
                        [LMS API Event Entry DE] as lms2
                    where
                        action = 'UnPublished'
                        and lms2.entityid = lms1.entityid
                    order by
                        recordcreateddate desc
                )
        ) then 'True'
        when dfm.discussionforumid in (
            select
                lms.entityid
            from
                [LMS API Event Entry DE] as lms
                inner join [LMS API Event Entry DE] as lms1 on lms1.entityid = lms.entityid
            where
                lms.action = 'Published'
                and lms1.action = 'Unpublished'
                and lms1.recordcreateddate < lms.recordcreateddate
                and lms1.recordcreateddate in (
                    Select
                        top 1 recordcreateddate
                    from
                        [LMS API Event Entry DE] as lms2
                    where
                        action = 'UnPublished'
                        and lms2.entityid = lms1.entityid
                    order by
                        recordcreateddate desc
                )
        ) then 'False'
    end as Unpublished,
    dfm.discussionforumid
from
    [Discussion Forum Master Data] as dfm
    inner join [LMS API Event Entry DE] on entityid = dfm.discussionforumid
where
    action in ('UnPublished', 'Published')
    and entitytype = 'Discussion Forum'