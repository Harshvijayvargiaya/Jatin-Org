trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert) {
    if (trigger.isInsert && trigger.isBefore) {
        Set<Id> oppIds = new Set<Id>();
        Set<Id> proIds = new Set<Id>();
        for (OpportunityLineItem oli : Trigger.new) {
            oppIds.add(oli.OpportunityId);
            proIds.add(oli.product2id);
        }
        if (!oppIds.isEmpty() && !proIds.isEmpty()) {
            Map<Id, Opportunity> mapOpp = new Map<Id, Opportunity>([SELECT id, services__c FROM Opportunity WHERE id IN :oppIds]);
            Map<Id, Product2> mapProd = new Map<Id, Product2>([SELECT id, family FROM Product2 WHERE id IN :proIds]);
            for (OpportunityLineItem oli : Trigger.new) {
                if (mapOpp.get(oli.OpportunityId).Services__c != mapProd.get(oli.product2id).family) {
                    oli.addError('Should be same.');
                }
            }
        }
    }
}