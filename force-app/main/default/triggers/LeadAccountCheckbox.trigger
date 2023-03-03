trigger LeadAccountCheckbox on Lead (after insert, after update) {
  Set<Id> accountIds = new Set<Id>();
  for (Lead lead : Trigger.new) {
    if (lead.Account__c != null) {
      accountIds.add(lead.Account__c);
    }
  }
  List<Account> accounts = [SELECT Id, Active1__c FROM Account WHERE Id IN :accountIds];
  for (Account account : accounts) {
    for (Lead lead : Trigger.new) {
      if (lead.Account__c == account.Id) {
        account.Active1__c = lead.Active1__c;
      }
    }
  }
  update accounts;
}