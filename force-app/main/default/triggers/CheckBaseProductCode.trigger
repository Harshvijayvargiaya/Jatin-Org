trigger CheckBaseProductCode on OpportunityLineItem (before insert) {
    if(Trigger.isInsert && Trigger.isBefore){
        System.debug('@@@@');
        Set<String> proIds = new Set<String>();
        for (OpportunityLineItem oli : Trigger.new) {
            proIds.add(oli.Product2Id);
        }
        Set<String> baseProductCodes = new Set<String>();
        Map<Id,Product2> proMap = new Map <Id,Product2>([Select id,Name,Productcode,Base_Product_Code__c from Product2 
                                                         where Id in : proIds]);
        Map<String,Product2> productCodeObjMap = new Map<String,Product2>();
        for(Product2 proObj : proMap.values()){
            if(proObj.Base_Product_Code__c != null && proObj.Base_Product_Code__c != ''){
                baseProductCodes.add(proObj.Base_Product_Code__c);
            }
            productCodeObjMap.put(proObj.Productcode,proObj);
        }
        if(baseProductCodes.size() > 0){
            for(Product2 prod : [Select Id,Name,Base_Product_Code__c,Productcode from Product2 where ProductCode in : baseProductCodes]){
                proMap.put(prod.Id, prod);
                productCodeObjMap.put(prod.Productcode,prod);
            }
        }
        System.debug(productCodeObjMap);
        List<OpportunityLineItem> newOLIs = new List<OpportunityLineItem>();
        for(OpportunityLineItem oli : trigger.new){
            //System.debug('#1');
            //System.debug(proMap.containsKey(oli.Product2Id));
            //System.debug(proMap.get(oli.Product2Id).Base_Product_Code__c);
            if(proMap.containsKey(oli.Product2Id) && proMap.get(oli.Product2Id).Base_Product_Code__c != null){
                System.debug('#2');
                if(productCodeObjMap.containsKey(proMap.get(oli.Product2Id).Base_Product_Code__c)){
                    System.debug('#3');
                    Product2 baseProductRec = productCodeObjMap.get(proMap.get(oli.Product2Id).Base_Product_Code__c);
                    System.debug(baseProductRec);
                    if(!proIds.contains(baseProductRec.Id)){
                        System.debug('#4');
                        System.debug(oli);
                        OpportunityLineItem newOLI = new OpportunityLineItem();
                        newOLI.OpportunityId = oli.OpportunityId;
                        newOLI.Quantity = oli.Quantity;
                        newOLI.PricebookEntryId = oli.PricebookEntryId;
                        newOLI.Product2Id = baseProductRec.Id;
                        newOLI.TotalPrice= 500;
                        newOLIs.add(newOLI);
                    }
                }
            }
        }
        System.debug(newOLIs.size());
        System.debug(newOLIs);
        if(newOLIs.size() > 0){
            System.debug('#5');
            insert newOLIs;
        }
    }
}