Select
    case
        when qm.assignmentId in (
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
        and qm.assignmentId not in (
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
        when qm.assignmentId in (
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
    qm.assignmentId
from
    [Assignment Master Data] as qm
    inner join [LMS API Event Entry DE] as lms on entityId = qm.assignmentId
where
    action in ('UnPublished', 'Published')
    and entityType = 'Assignment'