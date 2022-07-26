## Einstein_MC_MobilePush_Scores

**Description:** Einstein Engagement Scores For Mobile Push

**Folder:** Data Extensions/System DE/

**Fields in table:** 14

**Sendable:** Yes (`SubscriberKey` to `Subscriber Key`)

**Testable:** No

| Name | FieldType | MaxLength | IsPrimaryKey | IsNullable | DefaultValue |
| --- | --- | --- | --- | --- | --- |
| SubscriberKey | Text | 255 | + | - |  |
| AppID | Text | 255 | + | - |  |
| DirectOpenScore | Decimal | 18 | - | + |  |
| DirectOpenLevel | Text | 255 | - | + |  |
| InferredOpenScore | Decimal | 18 | - | + |  |
| InferredOpenLevel | Text | 255 | - | + |  |
| PredictedSessionsScore | Decimal | 18 | - | + |  |
| PredictedSessionsLevel | Text | 255 | - | + |  |
| PredictedTimeInApp | Decimal | 18 | - | + |  |
| PredictedTimeInAppLevel | Text | 255 | - | + |  |
| EngagementScore | Decimal | 18 | - | + |  |
| EngagementPersona | Text | 255 | - | + |  |
| CreatedDate | Date |  | - | - | getdate() |
| UpdatedDate | Date |  | - | - | getdate() |
