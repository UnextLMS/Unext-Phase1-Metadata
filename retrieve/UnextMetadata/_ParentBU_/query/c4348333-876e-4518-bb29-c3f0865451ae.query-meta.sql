select
    distinct u.Id as userId,
    u.Name as name,
    u.Email as emailAddress,
    u.MobilePhone as phoneNumber,
    qm.liveClassroomTitle,
    q.entityId,
    qm.liveClassroomLink,
    qm.startDate,
    q.choice,
    q.type,
    q.courseOfferingId,
    ce.lumen__unCourse_Name__c as courseName,
    'Remainder' as action,
    'Live Classroom Reminder' as title,
    concat(
        'Your''s live class',
        ' ',
        qm.liveClassroomTitle,
        ' ',
        'for : ',
        ' ',
        ce.lumen__unCourse_Name__c,
        ' ',
        'will start at',
        ' ',
        qm.startDate,
        '.'
    ) as body,
    concat(q.entityId, u.Id, 'Remainder') as newId,
    concat(u.Id, q.entityId) as uniqueId
FROM
    lumen__unUser_Enrollment__c_Salesforce as ue
    inner join User_Salesforce as u on ue.lumen__unUser__c = u.Id
    inner join hed__Course_Enrollment__c_Salesforce as ce on ce.hed__Course_Offering__c = ue.lumen__unRecord_Ids__c
    inner join [LMS API Event Entry DE] as q on q.CourseOfferingId = ce.hed__Course_Offering__c
    inner join [Live Classroom Master Data] as qm on q.entityId = qm.liveClassroomId
where
    u.lumen__unProfile_Name__c = 'Faculty'
    And u.IsActive = 'True'
    And q.entityType = 'Live Classroom'
    And ue.lumen__unRecord_Ids__c = qm.CourseOfferingId
    And datepart(day, dateadd(day, -1, qm.startDate)) = datepart(day, GETUTCDATE())
    And qStatus = 'False'