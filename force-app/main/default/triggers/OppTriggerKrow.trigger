trigger OppTriggerKrow on Opportunity (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        List<Krow_Project__c> krowList=new List<Krow_Project__c>();
        for(opportunity oppObj : trigger.new){
            opportunity oppObjOld = Trigger.oldMap.get(oppObj.ID);
            if(oppObj.StageName =='Signature' && oppObjOld.StageName !='Signature'){
                Krow_Project__c krowObj=new Krow_Project__c();
                krowObj.Onboarding_Type__c='Customer Onboarding';
                krowObj.Opportunity__c = oppObj.Id;
                krowList.add(krowObj);
            }
        }
        if(!krowList.isEmpty()){
            insert krowList;
        }
    }  
}