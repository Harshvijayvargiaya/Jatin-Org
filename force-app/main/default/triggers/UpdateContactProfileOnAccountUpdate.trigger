trigger UpdateContactProfileOnAccountUpdate on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : Trigger.new) {
            if (acc.Website != null && acc.Website != Trigger.oldMap.get(acc.Id).Website) {
                accountIds.add(acc.Id);
            }
        }
        if (!accountIds.isEmpty()) {
            List<Contact> contactsToUpdate = new List<Contact>();
            for (Contact con : [SELECT Id, AccountId, Account.Website, FirstName, LastName, Profile__c FROM Contact WHERE AccountId IN :accountIds]) {
                if (con.Account != null && con.Account.Website != null && con.FirstName !=null && con.LastName !=null) {
                    String newProfile = con.Account.Website + '/' + con.FirstName.substring(0, 1) + con.LastName;
                    if (newProfile != con.Profile__c) {
                        con.Profile__c = newProfile;
                        contactsToUpdate.add(con);
                    }
                }
            }
            if (!contactsToUpdate.isEmpty()) {
                update contactsToUpdate;
            }
        }
    }
}