trigger OpportunityStageChangeTrigger on Opportunity (before update) {
    if(trigger.isbefore && trigger.isupdate){
        Set<Id> opportunityIdSet=new Set<Id>();
        for (Opportunity opp : Trigger.new) {
            Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
            if (oldOpp.StageName == 'Prospecting' && opp.StageName != 'Prospecting') {
                opportunityIdSet.add(opp.Id);
            }
        }
        if(!opportunityIdSet.isEmpty()){
            Map<Id,Opportunity> oppLineItemsMap=new Map<Id,Opportunity>([SELECT Id,(SELECT Id FROM OpportunityLineItems)FROM Opportunity WHERE Id In: opportunityIdSet]);
            for(Opportunity oppObj : trigger.new){
                if(oppLineItemsMap.containsKey(oppObj.Id) && oppLineItemsMap.get(oppObj.Id).OpportunityLineItems.size()==0){
                    oppObj.addError('Cannot change stage as the product is not available');
                }
            }
        }
    }
}