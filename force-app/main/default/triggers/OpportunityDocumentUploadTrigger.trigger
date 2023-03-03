trigger OpportunityDocumentUploadTrigger on Opportunity (before insert,before update,after insert) {
    if(trigger.isbefore || trigger.isafter){
        if(trigger.isUpdate || trigger.isinsert){
            Set<Id> oppIdSet=new Set<Id>();
            for(Opportunity oppObj : trigger.new){
                if(oppObj.StageName == 'Closed Won'){
                    oppIdSet.add(oppObj.Id);
                }
            }
            if(!oppIdSet.isEmpty()){
                Map<Id,Opportunity> oppAttachmentMap=new Map<Id,Opportunity>([SELECT id, (SELECT parentId FROM CombinedAttachments)
                                                                              FROM Opportunity WHERE Id In: oppIdSet]);
                for(Opportunity oppObj : trigger.new){
                    if(oppAttachmentMap.containsKey(oppObj.Id)){
                        if(oppAttachmentMap.get(oppObj.Id).CombinedAttachments.size()==0){
                            oppObj.addError('Add Attachment first and then make check box checked.');
                        }
                        else{
                            if(oppObj.Document_Upload__c==false){
                                oppObj.addError('Make check box checked.');
                            }
                        }
                    }
                }
            } 
        }
    }
}