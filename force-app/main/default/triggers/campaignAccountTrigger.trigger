trigger campaignAccountTrigger on CampaignMember (after insert) {
    if(Trigger.isInsert && Trigger.isAfter){
        List<Account> accList=new List<Account>();
        Set<id> conId =new Set<id>();
        for(CampaignMember cm : trigger.new){
            conId.add(cm.Contactid);
        }
        Map<Id,Contact> cmMap= new Map<Id,Contact>([Select Accountid from Contact where id in :conId]); 
        Set<Id> accId1 = new Set<Id>();
        for(Contact conObj : cmMap.values()){
            accId1.add(conObj.Accountid);
        }
        /*Set<id> conId =new Set<id>();
for(CampaignMember cm : trigger.new){
System.debug('##1');
conId.add(cm.Contact.accountId);
}*/
        List<AggregateResult> groupedResults = [Select count(id) ids, CampaignMember.contact.accountid accId from CampaignMember 
                                                where contact.accountid IN : accId1 group by CampaignMember.contact.accountid];
        System.debug(groupedResults);
        for(AggregateResult agg : groupedResults){
            Account acc = new Account();  
            acc.id = String.valueOf(agg.get('accId'));
            acc.Number_of_Campaign_Members__c= (Decimal)agg.get('ids');
            accList.add(acc);
            
        }
        System.debug('update accList; :'+ accList);
        if(!accList.isEmpty()){
            update accList;   
        }
    }
}