## 534002955-PredictiveScoring-PSMain

**Name** (not equal to External Key)**:** UNext Learning Private Limited (Part of M-12166-534002955-PSMain

**Description:** This automation sends CURRENT data to the Data Scientists for scoring and is an important componentof the Einstein Engagement Scoring application.

**Folder:** my automations/Data Factory Utility Automations/

**Started by:** Schedule

**Status:** Scheduled

**Schedule:**

* Start: 2022-03-07 14:28:48.55 -06:00
* End: 2052-03-05 14:28:48 -06:00
* Timezone:  Central Standard Time (no DST)
* Recurrance: every 24 hours for 10957 times

| Step 1<br>_Predictive Scoring extract-upload task #01_ | Step 2<br>_Predictive Scoring extract-upload task #02_ | Step 3<br>_Predictive Scoring extract-upload task #03_ | Step 4<br>_Predictive Scoring extract-upload task #04_ | Step 5<br>_Predictive Scoring extract-upload task #05_ | Step 6<br>_Predictive Scoring extract-upload task #06_ | Step 7<br>_Predictive Scoring extract-upload task #07_ | Step 8<br>_Predictive Scoring extract-upload task #08_ | Step 9<br>_Predictive Scoring extract-upload task #09_ |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| _1.1: dataFactoryUtility_<br>Extract-Upload stats.Bounce into S3 | _2.1: dataFactoryUtility_<br>Extract-Upload Stats.RefererEmailClient into S3 | _3.1: dataFactoryUtility_<br>Extract-Upload C534002955._GeofenceDefinition into S3 | _4.1: dataFactoryUtility_<br>Extract-Upload C534002955.PSConfig into S3 | _5.1: dataFactoryUtility_<br>Extract-Upload C534002955._MobileMessage into S3 | _6.1: dataFactoryUtility_<br>Extract-Upload C534002955.SmsMemberSharedShortCode_Config into S | _7.1: dataFactoryUtility_<br>Extract-Upload dbo.EmailSendDefinition into S3 | _8.1: dataFactoryUtility_<br>Extract-Upload dbo.EnterpriseMember into S3 | _9.1: dataFactoryUtility_<br>Extract-Upload C534002955.VPS_ExportDone into S3 |
| _1.2: dataFactoryUtility_<br>Extract-Upload stats.BounceDecrementQueue into S3 | _2.2: dataFactoryUtility_<br>Extract-Upload stats.Send into S3 | _3.2: dataFactoryUtility_<br>Extract-Upload C534002955._MobileAddress into S3 | _4.2: dataFactoryUtility_<br>Extract-Upload dbo.ProgramActivityInstance into S3 | _5.2: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSend into S3 | _6.2: dataFactoryUtility_<br>Extract-Upload C534002955.SmsMemberShortCodeDistinct into S3 | _7.2: dataFactoryUtility_<br>Extract-Upload dbo.Send into S3 | _8.2: dataFactoryUtility_<br>Extract-Upload dbo.MemberTimeZone into S3 | - |
| _1.3: dataFactoryUtility_<br>Extract-Upload stats.Click into S3 | _2.3: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentApplication into S3 | _3.3: dataFactoryUtility_<br>Extract-Upload C534002955._MobileMessageTracking into S3 | _4.3: dataFactoryUtility_<br>Extract-Upload dbo.ProgramInstance into S3 | _5.3: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSendJob into S3 | _6.3: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSendContent into S3 | _7.3: dataFactoryUtility_<br>Extract-Upload dbo.tblEmails into S3 | _8.3: dataFactoryUtility_<br>Extract-Upload dbo.SendDefType into S3 | - |
| _1.4: dataFactoryUtility_<br>Extract-Upload stats.Complaint into S3 | _2.4: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentDevice into S3 | _3.4: dataFactoryUtility_<br>Extract-Upload C534002955._PushAddress into S3 | _4.4: dataFactoryUtility_<br>Extract-Upload InteractionStudio.Activity into S3 | _5.4: dataFactoryUtility_<br>Extract-Upload dbo.CampaignAsset into S3 | _6.4: dataFactoryUtility_<br>Extract-Upload dbo.ABTestSendType into S3 | _7.4: dataFactoryUtility_<br>Extract-Upload dbo.tblLists into S3 | _8.4: dataFactoryUtility_<br>Extract-Upload dbo.tblMembers into S3 | - |
| _1.5: dataFactoryUtility_<br>Extract-Upload stats.Conversion into S3 | _2.5: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentEmailClient into S3 | _3.5: dataFactoryUtility_<br>Extract-Upload C534002955._PushAddressExtension into S3 | _4.5: dataFactoryUtility_<br>Extract-Upload InteractionStudio.DefinitionInfo into S3 | _5.5: dataFactoryUtility_<br>Extract-Upload dbo.CampaignAssetType into S3 | _6.5: dataFactoryUtility_<br>Extract-Upload dbo.CampaignDefinition into S3 | - | _8.5: dataFactoryUtility_<br>Extract-Upload dbo.TimeZoneDetail into S3 | - |
| _1.6: dataFactoryUtility_<br>Extract-Upload stats.Open into S3 | _2.6: dataFactoryUtility_<br>Extract-Upload Stats.UserAgentOperatingSystem into S3 | _3.6: dataFactoryUtility_<br>Extract-Upload C534002955._PushApplicationCache into S3 | _4.6: dataFactoryUtility_<br>Extract-Upload InteractionStudio.EventDefinition into S3 | _5.6: dataFactoryUtility_<br>Extract-Upload dbo.CustomObject into S3 | _6.6: dataFactoryUtility_<br>Extract-Upload dbo.ImpressionRegion into S3 | - | - | - |
| _1.7: dataFactoryUtility_<br>Extract-Upload stats.Unsubscribe into S3 | - | _3.7: dataFactoryUtility_<br>Extract-Upload C534002955._PushDeviceLookup into S3 | _4.7: dataFactoryUtility_<br>Extract-Upload InteractionStudio.EventInstance into S3 | _5.7: dataFactoryUtility_<br>Extract-Upload dbo.JobCampaignDefinition into S3 | _6.7: dataFactoryUtility_<br>Extract-Upload dbo.JobImpressionRegion into S3 | - | - | - |
| - | - | _3.8: dataFactoryUtility_<br>Extract-Upload C534002955._PushDeviceStatistics into S3 | - | _5.8: dataFactoryUtility_<br>Extract-Upload dbo.Program into S3 | _6.8: dataFactoryUtility_<br>Extract-Upload dbo.Members_ into S3 | - | - | - |
| - | - | _3.9: dataFactoryUtility_<br>Extract-Upload C534002955._PushInAppStatisticsActivityAggregate  | - | _5.9: dataFactoryUtility_<br>Extract-Upload dbo.SendGroup into S3 | _6.9: dataFactoryUtility_<br>Extract-Upload dbo.SendSplit into S3 | - | - | - |
| - | - | _3.10: dataFactoryUtility_<br>Extract-Upload C534002955._PushMessage into S3 | - | _5.10: dataFactoryUtility_<br>Extract-Upload dbo.SendJob into S3 | _6.10: dataFactoryUtility_<br>Extract-Upload dbo.Subscriber into S3 | - | - | - |
| - | - | _3.11: dataFactoryUtility_<br>Extract-Upload C534002955._PushMessageAudience into S3 | - | _5.11: dataFactoryUtility_<br>Extract-Upload dbo.SimpleTag into S3 | _6.11: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs into S3 | - | - | - |
| - | - | _3.12: dataFactoryUtility_<br>Extract-Upload C534002955._PushMessageInApp into S3 | - | _5.12: dataFactoryUtility_<br>Extract-Upload dbo.SimpleTagObject into S3 | _6.12: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs_Lists into S3 | - | - | - |
| - | - | _3.13: dataFactoryUtility_<br>Extract-Upload C534002955._PushMessageTracking into S3 | - | _5.13: dataFactoryUtility_<br>Extract-Upload dbo.SimpleTagObjectType into S3 | _6.13: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs_URLs into S3 | - | - | - |
| - | - | _3.14: dataFactoryUtility_<br>Extract-Upload C534002955._PushSubscriptionHistory into S3 | - | _5.14: dataFactoryUtility_<br>Extract-Upload dbo.SourceAddress into S3 | _6.14: dataFactoryUtility_<br>Extract-Upload dbo.tblSurveyQuestions into S3 | - | - | - |
| - | - | _3.15: dataFactoryUtility_<br>Extract-Upload C534002955._PushTag into S3 | - | _5.15: dataFactoryUtility_<br>Extract-Upload dbo.tblJobs_Surveys into S3 | - | - | - | - |
| - | - | _3.16: dataFactoryUtility_<br>Extract-Upload C534002955.VPS_Einstein_MC_MobilePush_Scores into | - | _5.16: dataFactoryUtility_<br>Extract-Upload dbo.tblJobSubscriberBatch into S3 | - | - | - | - |
| - | - | _3.17: dataFactoryUtility_<br>Extract-Upload dbo.Asset into S3 | - | _5.17: dataFactoryUtility_<br>Extract-Upload dbo.tblSurveyAnswers into S3 | - | - | - | - |
| - | - | _3.18: dataFactoryUtility_<br>Extract-Upload dbo.PushApplicationConfig into S3 | - | _5.18: dataFactoryUtility_<br>Extract-Upload dbo.TriggeredSendJob into S3 | - | - | - | - |
| - | - | - | - | _5.19: dataFactoryUtility_<br>Extract-Upload InteractionStudio.Definition into S3 | - | - | - | - |
