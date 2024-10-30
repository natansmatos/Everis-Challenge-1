trigger LeadTrigger on Lead (after insert, after update, after delete, after undelete) {
    if(Trigger.isInsert && Trigger.isAfter){
        LeadTriggerHandler.createTaskForLead(Trigger.new);
    }
}