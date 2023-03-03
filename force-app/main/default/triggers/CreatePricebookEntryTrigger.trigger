trigger CreatePricebookEntryTrigger on Product2 (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            List<PricebookEntry> pbeList = new List<PricebookEntry>();
            Map<Id, Product2> product2Map = new Map<Id, Product2>();
            Set<Id> product2Ids = new Set<Id>();
            Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE IsStandard=true];
            
            if (Trigger.isInsert) {
                for (Product2 prod : Trigger.new) {
                    product2Map.put(prod.Id, prod);
                    product2Ids.add(prod.Id);
                }
            } else if (Trigger.isUpdate) {
                for (Product2 prod : Trigger.new) {
                    if (prod.Price__c != Trigger.oldMap.get(prod.Id).Price__c) {
                        product2Map.put(prod.Id, prod);
                        product2Ids.add(prod.Id);
                    }
                }
            }
            if (!product2Ids.isEmpty()) {
                Map<Id, PricebookEntry> PBEMap = new Map<Id, PricebookEntry>();
                for (PricebookEntry pbeObj : [SELECT Id, Product2Id, UnitPrice FROM PricebookEntry 
                                              WHERE Product2Id IN :product2Ids AND Pricebook2Id =:pb.Id]) {
                    PBEMap.put(pbeObj.Product2Id, pbeObj);
                }
                
                for (Id prodId : product2Ids) {
                    Product2 prod = product2Map.get(prodId);
                    PricebookEntry pbeObj = new PricebookEntry();
                    pbeObj.Product2Id = prod.Id;
                    pbeObj.Pricebook2Id = pb.Id;
                    pbeObj.UnitPrice = prod.Price__c;
                    
                    if (PBEMap.containsKey(prodId)) {
                        pbeObj.Id = PBEMap.get(prodId).Id;
                        pbeList.add(pbeObj);
                    }
                    else {
                        pbeList.add(pbeObj);
                    }
                }
                if (!pbeList.isEmpty()) {
                    upsert pbeList;
                }
            }
        }
    } 
}