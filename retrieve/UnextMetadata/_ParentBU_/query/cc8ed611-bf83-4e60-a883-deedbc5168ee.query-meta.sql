Select
    qm.liveclassroomid,
    case
        when qm.liveclassroomid in (
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
        and qm.liveclassroomid not in (
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
        when qm.liveclassroomid in (
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
    end as Unpublished
from
    [Live Classroom Master Data] as qm
    inner join [LMS API Event Entry DE] on entityId = qm.liveClassroomId
where
    action in ('UnPublished', 'Published')
    and entityType = 'Live Classroom'