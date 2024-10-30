public with sharing class LeadTriggerHandler {
    public static void createTaskForLead(List<Lead> newLeadRecords){
        Set<Id> leadsId = new Set<Id>();
        for(Lead lead : newLeadRecords){
            leadsId.add(lead.Id);
        }
        List<Lead> leadList = [SELECT Id, Contact_Options__c FROM Lead WHERE Id IN : leadsId AND Contact_Options__c INCLUDES ('SMS','WhatsApp')];
        if(!leadList.isEmpty()){
            List<Task> taskList = new List<Task>();
            for(Lead l : leadList){
                if(l.Contact_Options__c.contains(';')){
                    taskList.addAll(createTasksForMoreThanOneContactOption(l));
                }
                else{
                    taskList.add(new Task(Subject = l.Contact_Options__c, WhoId = l.Id, Status = 'Not Started', Priority = 'Normal'));
                }   
            }   
            insert taskList; 
        }  
    }

    private static List<Task> createTasksForMoreThanOneContactOption(Lead lead){
        List<Task> listForMultipleContactOptions = new List<Task>();
        if(lead.Contact_Options__c.contains('SMS') && lead.Contact_Options__c.contains('WhatsApp')){
            listForMultipleContactOptions.add(new Task(Subject = 'SMS', WhoId = lead.Id, Status = 'Not Started', Priority = 'Normal'));
            listForMultipleContactOptions.add(new Task(Subject = 'WhatsApp', WhoId = lead.Id, Status = 'Not Started', Priority = 'Normal'));
        }
        if(lead.Contact_Options__c.contains('SMS') || lead.Contact_Options__c.contains('WhatsApp')){
            String taskSubject;
            if(lead.Contact_Options__c.contains('SMS')){
                taskSubject = 'SMS';
            }
            else if(lead.Contact_Options__c.contains('WhatsApp')){
                taskSubject = 'WhatsApp';
            }
            listForMultipleContactOptions.add(new Task(Subject = taskSubject, WhoId = lead.Id, Status = 'Not Started', Priority = 'Normal'));
        }
        return listForMultipleContactOptions;
    }
}