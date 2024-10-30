This is a project based on a test for a job at Everis.

Requirements: 
1. Trigger – Create a trigger to meet the following requirements:<br/>
	a) Create a field in Lead of type multi-select picklist called “Contact Options” (Contact_Options__c) with the following options: Phone, Email, Whatsapp, and SMS.<br/>
	b) Create an after insert trigger on the Lead object that will create tasks for each Lead created, considering if the “Contact Methods” field has one of the following values: “SMS” or “Whatsapp”.<br/>
	i. The trigger should create a task for each type of contact that is selected, meaning if both options are selected, two tasks will be created for the newly created Lead.<br/>
	ii. Fill in the fields: Subject with the “Contact Method”; WhoId with the Id of the inserted Lead, Status with “Not Started”; Priority with “Normal”.<br/>

3. Test Class – Write a test class that validates the trigger from the previous item.<br/>
	a) The class from the previous item needs to have 100% coverage.<br/>
	b) It should account for bulk inserts.

Solution:
  1. Created the class LeadTrigger and LeadTriggerHandler to deal with the creation of determined tasks.
  2. Created the class LeadTriggerHandlerTest to test for different scenarios and achieve 100% coverage.
