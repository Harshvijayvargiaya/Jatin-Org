trigger AccountsRelationshipMapsTriggers on Accounts_Relationship_Map__c (after insert, after update, before delete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            Map<Id, Id> accountRelationshipMap = new Map<Id, Id>();
            for (Accounts_Relationship_Map__c mapObj : Trigger.new) {
                accountRelationshipMap.put(mapObj.From_Account__c, mapObj.To_Account__c);
            }
            if (!accountRelationshipMap.isEmpty()) {
                List<Contact> clones = new List<Contact>();
                for (Contact conObj : [SELECT Id, FirstName, LastName, Phone, AccountId,parent_contact__c FROM Contact WHERE AccountId IN :accountRelationshipMap.keySet()]) {
                    Contact clone = conObj.clone(false,true);
                    clone.Id=null;
                    clone.AccountId = accountRelationshipMap.get(clone.AccountId);
                    clone.parent_contact__c=conObj.Id;
                    clones.add(clone);
                }
                if (!clones.isEmpty()) {
                    insert clones;
                }
            }
        }
    }
    if (Trigger.isDelete && Trigger.isBefore) {
        Set<Id> accountIds = new Set<Id>();
        for (Accounts_Relationship_Map__c mappingRecord : Trigger.old) {
            accountIds.add(mappingRecord.To_Account__c);
        }
        List<Contact> clonedRecordsToDelete = new List<Contact>();
        for(Contact conObj: [SELECT Id, FirstName, LastName, Phone FROM Contact WHERE Parent_contact__c IN :accountIds]){
            clonedRecordsToDelete.add(conObj);
        }
        delete clonedRecordsToDelete;
    }
}