trigger OrderTriggerKrow on Order (after update, before update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        Set<Id> setOfId = new Set<Id>();
        for(Order obj : trigger.new){
            setOfId.add(obj.opportunityId);
        }
        if(!setOfId.isEmpty()){
            Map<Id, String> oppMap = new Map<Id, String>();
            for(Opportunity opp : [Select id, stageName from Opportunity where id IN : setOfId]){
                oppMap.put(opp.id, opp.stageName);
            }
            for(Order o : Trigger.new){
                if(o.Status == 'Activated' && o.opportunityId != null && oppMap.containsKey(o.OpportunityId) && oppMap.get(o.OpportunityId) != 'Signature'){
                    o.addError('Cannot mark Order as Completed if Opportunity Stage is not Signature.');
                }
            }
        }
    }
    if(trigger.isUpdate && trigger.isAfter){
        List<Krow_Project__c> krowList=new List<Krow_Project__c>();
        Set<Id> oppIds = new Set<Id>();
        for(Order orderObj : trigger.new){
            Order orderObjOld = Trigger.oldMap.get(orderObj.ID);
            if(orderObj.Status =='Activated' && orderObjOld.Status !='Activated'){
                Krow_Project__c krowObj=new Krow_Project__c();
                krowObj.Onboarding_Type__c='Installation';
                krowObj.Order__c = orderObj.Id;
                oppIds.add(orderObj.AccountId);
                krowList.add(krowObj);
            }
        }
        if(!krowList.isEmpty()){
            insert krowList;
        }
        List<Contact> clones = new List<Contact>();
        List<Krow_Task__c> KTList = new List<Krow_Task__c>();
        for (Krow_Task__c templateTasks : [SELECT Id,Name,Status__c FROM Krow_Task__c WHERE Krow_Project__r.isTemplateKrow__c=true]) {
            for(Integer i=0;i<krowList.size();i++){
                Krow_Task__c clone = templateTasks.clone(false,true);
                clone.Krow_Project__c=krowList[i].id;
                clone.Id=null;
                clone.Name = templateTasks.Name;
                clone.Status__c=templateTasks.Status__c;
                KTList.add(clone);
            }
        }
        if(!KTList.isEmpty()){
            insert KTList;
        }
    }
}