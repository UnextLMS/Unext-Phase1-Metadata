select
    t.Name,
    con.hed__Chosen_Full_Name__c as fullName,
    con.Email,
    pgme.hed__Contact__c as contactId,
    t.OEBS_Slot_Booking_Start_Time__c as examBookingStartDate,
    t.OEBS_Slot_Booking_End_Time__c as examBookingEndDate
from
    hed__Term__c_Salesforce t
    join Term_Enrollment__c_Salesforce te on t.Id = te.Term__c
    join hed__Program_Enrollment__c_Salesforce pgme on pgme.Id = te.Program_Enrollment__c
    join Contact_Salesforce con on con.Id = pgme.hed__Contact__c
where
    pgme.hed__Enrollment_Status__c = 'Active'
    and t.OEBS_Slot_Booking_Start_Time__c is not null