## CCEC0190-AD19-4499-BFFA-AE06EEDC5B30

**Name** (not equal to External Key)**:** June29th testing1

**Description:** n/a

**Folder:** Data Extensions/Audiences/

**Fields in table:** 13

**Sendable:** Yes (`SubscriberKey` to `Subscriber Key`)

**Testable:** No

**Template:** AudienceBuilderResult

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberKey | Text | 254 | + | - |  |
| CustomerKey | Text | 256 | - | - |  |
| AudienceId | Text |  | - | - |  |
| TrackingCode | Text | 256 | - | - |  |
| AudienceCode | Text | 64 | - | - |  |
| SegmentCode | Text | 64 | - | - | EmptyString() |
| SegmentName | Text | 128 | - | - | EmptyString() |
| Priority | Number |  | - | - |  |
| SegmentID | Text |  | - | - |  |
| SplitID | Text |  | - | - |  |
| SplitName | Text | 128 | - | - | EmptyString() |
| SplitCode | Text | 64 | - | - | EmptyString() |
| SendGroupID | Text |  | + | - |  |