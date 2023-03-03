trigger UpdateOutOfZip on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Map<Id, String> accountPostalCodes = new Map<Id, String>();
        for (Account acct : Trigger.new) {
            Account oldAcct = Trigger.oldMap.get(acct.Id);
            if (acct.BillingPostalCode != oldAcct.BillingPostalCode) {
                accountPostalCodes.put(acct.Id, acct.BillingPostalCode);
            }
        }
        if (!accountPostalCodes.isEmpty()){
            Set<Id> accountIds = accountPostalCodes.keySet();
            Map<Id, Boolean> accountHasOutOfZipContact = new Map<Id, Boolean>();
            for (Contact contact : [SELECT AccountId, MailingPostalCode FROM Contact WHERE AccountId IN :accountIds]) {
                if (contact.MailingPostalCode != accountPostalCodes.get(contact.AccountId)){
                    accountHasOutOfZipContact.put(contact.AccountId, true);
                }
                else{
                    accountHasOutOfZipContact.put(contact.AccountId, false);
                }
            }
            List<Account> accountsToUpdate = new List<Account>();
            for (Id accountId : accountHasOutOfZipContact.keySet()) {
                Account acct = new Account(Id = accountId, Out_of_Zip__c = accountHasOutOfZipContact.get(accountId));
                accountsToUpdate.add(acct);
            }
            if(!accountsToUpdate.isEmpty()){
                update accountsToUpdate;
            }
        }
    }       
}