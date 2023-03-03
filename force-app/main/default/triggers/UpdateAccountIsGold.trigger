trigger UpdateAccountIsGold on Opportunity (after insert, after update) {
    if(trigger.isAfter){
        if(trigger.isUpdate || trigger.isInsert){
            Set<Id> accountIds = new Set<Id>();
            for (Opportunity opp : Trigger.new) {
                accountIds.add(opp.AccountId);
            }
            if(!accountIds.isEmpty()){
                Account acc = [select id from account where id IN : accountIds];
                Map<Id,Account> ampOfAcc = new Map<Id, Account>();
                for(opportunity opp : [select id,amount, account.Is_gold__c from opportunity where accountId IN : accountIds]){
                    if(opp.amount >=20000){
                        acc.Is_gold__c=true;
                        ampOfAcc.put(opp.AccountId, acc);
                    }
                    else if(opp.account.Is_gold__c=true && opp.amount <20000){
                        acc.Is_gold__c=false;
                        ampOfAcc.put(opp.AccountId, acc);
                    }
                }
                if(!ampOfAcc.isEmpty()){
                    update ampOfAcc.values();
                }
            }        
        }
    }
}