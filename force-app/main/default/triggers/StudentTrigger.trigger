trigger StudentTrigger on student__c (after Insert,after update){
    if((Trigger.isafter && Trigger.isInsert)||(Trigger.isafter && Trigger.isUpdate)){
        Set<Id> classIdSet=new Set<Id>();
        for(Student__c stuObj : trigger.new){
            if(stuObj.Class__c != null && (trigger.isInsert || (trigger.isUpdate && stuobj.Class__c != trigger.oldMap.get(stuObj.id).Class__c))){
                classIdSet.add(stuObj.Class__c);
            }
        }
        if(classIdSet!=null){
            Map<Id,Class__c> classMap= new Map<Id,Class__c>([SELECT Id,(SELECT Id FROM Student__r) FROM Class__c 
                                                             WHERE Class__c.Id =: classIdSet]);
            for(Student__c stuObj : trigger.new){
                if(classMap.containsKey(stuObj.Class__c) && classMap.get(stuObj.Class__c).Student__r.size()>=10){
                    stuObj.addError('You can not add more than 10 students in a single class.');
                }  
            }
        }
    }
}