select
    dateadd(hour, 10, dateadd(minute, 30, startdate)) as startdate,
    dateadd(day, 1, startdate) as AllDayEventSD,
    dateadd(day, -1, enddate) as AllDayEventED,
    dateadd(hour, 10, dateadd(minute, 30, enddate)) as enddate,
    dateadd(
        second,
        -1,
        dateadd(
            day,
            1,
            dateadd(
                day,
                0 + datediff(day, '19000101', StartDate),
                '19000101'
            )
        )
    ) as NewStartDate,
    dateadd(
        second,
        -1,
        dateadd(
            day,
            1,
            dateadd(
                day,
                0 + datediff(day, '19000101', endDate),
                '19000101'
            )
        )
    ) as NewEndDate,
    '0039D00000Fv040QAB' as ContactId,
    '0059D000003dfMiQAI' as UserId
from
    [Discussion Forum LMS]