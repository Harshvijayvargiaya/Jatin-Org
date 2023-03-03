trigger OpportunityTrigger on Opportunity (after insert,after update) {
    if((trigger.isInsert && trigger.isAfter)||(trigger.isUpdate && trigger.isAfter)){
        Set<Id> idSet=new Set<Id>();
        Id accId;
        List<Account> accList =new List<Account>();
        for(Opportunity oppObj : trigger.new){
            if(oppObj.AccountId != null){
                idSet.add(oppObj.AccountId); 
                accId=oppObj.AccountId;
            }
        }
        if(idSet.size()>0){
            //Map<Id,Opportunity> accMap=new Map<Id,Opportunity>([SELECT AccountId,Id,Amount FROM Opportunity WHERE AccountId In: idSet]);
            //System.debug('This is Map '+accMap);
            Account accObj=new Account(id=accId);
            Integer count=0;
            accObj.Opp_amount_total__c=0;
            for (Opportunity opp : [SELECT AccountId,Id,Amount FROM Opportunity WHERE AccountId In: idSet]) {
                count++;
                if(opp.Amount!=null){
                    accObj.Opp_amount_total__c += opp.Amount;
                }
            }
            System.debug('opp Amount Total'+accObj.Opp_amount_total__c);
            System.debug('This is count'+count);
            accObj.Number_of_opportunities__c = count;
            accList.add(accObj);
        }
        System.debug('This is List '+accList);
        if (!accList.isEmpty()) {
            update accList;
        }
    }
}