trigger HireProcessTrigger on Hire_Process__c (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        List<Contact> conList=new List<Contact>();
        List<Hire_Process__c> hpList= new List<Hire_Process__c>();
        List<Id> idList= new List<Id>();
        for (Hire_Process__c hireObj : Trigger.new) {
            if(hireObj.Status__c == 'In Progress'){
                Contact conObj = new Contact();
                conObj.FirstName = hireObj.First_Name__c;
                conObj.LastName = hireObj.Last_Name__c;
                conObj.Email = hireObj.Email__c;
                conObj.Phone = hireObj.Phone__c;
                conList.add(conObj);
                hpList.add(hireObj);
            } 
        }
        if(conList!=null){
            insert conList;
            //idSet=new Map<Id, Case> (caseList).keySet();
            for(Contact conId : conList){
                idList.add(conId.id);
            }
            for(Integer i=0;i<hpList.size();i++){
                hpList[i].Candidate__c=idList[i];
            }
        }
    }
}