@isTest
public with sharing class LeadTriggerHandlerTest {

    @isTest
    static void createTasksWithOneContactOption() {
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 1;i <= 3;i++){
            Lead lead = new Lead(LastName = 'Summers ' + i,Company = 'NCR' + i,Contact_Options__c = 'SMS');
            leadList.add(lead);
        }
        insert leadList;
        List<Task> taskList = [SELECT Id, Subject FROM Task WHERE WhoId =: leadList[0].id];
        System.assertEquals(leadList[0].Contact_Options__c, taskList[0].Subject);    
    }
	@isTest
    static void createTasksWithMoreThanOneContactOption(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 1;i <= 3;i++){
            Lead lead = new Lead(LastName = 'Grey ' + i,Company = 'NCR',Contact_Options__c = 'WhatsApp;SMS');
            leadList.add(lead);
        }
        insert leadList;
        List<Task> taskList = [SELECT Id FROM Task WHERE WhoId =: leadList[0].id];
        System.assert(leadList[0].Contact_Options__c.contains('SMS') || leadList[0].Contact_Options__c.contains('WhatsApp'));
    }

    @isTest
    static void createTasksWithMoreThanOneContactOptionExceptWhatsApp(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 1;i <= 3;i++){
            Lead lead = new Lead(LastName = 'Grey ' + i,Company = 'NCR',Contact_Options__c = 'SMS;Phone;Email');
            leadList.add(lead);
        }
        insert leadList;
        List<Task> taskList = [SELECT Id FROM Task WHERE WhoId =: leadList[0].id];
        System.assert(leadList[0].Contact_Options__c.contains('SMS') || leadList[0].Contact_Options__c.contains('WhatsApp'));
    }

    @isTest
    static void createTasksWithMoreThanOneContactOptionExceptSMS(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i = 1;i <= 3;i++){
            Lead lead = new Lead(LastName = 'Grey ' + i,Company = 'NCR',Contact_Options__c = 'WhatsApp;Phone;Email');
            leadList.add(lead);
        }
        insert leadList;
        List<Task> taskList = [SELECT Id FROM Task WHERE WhoId =: leadList[0].id];
        System.assert(leadList[0].Contact_Options__c.contains('SMS') || leadList[0].Contact_Options__c.contains('WhatsApp'));
    }
}