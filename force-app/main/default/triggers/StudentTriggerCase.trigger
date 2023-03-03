trigger StudentTriggerCase on student__c (before insert) {
    if(trigger.isInsert && trigger.isBefore){
        List<Case> caseList=new List<Case>();
        List<student__c> stuList =new List<student__c>();
        List<Id> idList= new List<Id>();
        for(student__c stdObj : trigger.new){
            if(stdObj.Fee_Status__c=='Defaulter'){
                Case caseObj=new Case();
                caseObj.Subject='Defaulter '+stdObj.Name;
                caseObj.Status='New';
                caseObj.Origin='Web';
                caseList.add(caseObj);
                stuList.add(stdObj);
            }
        }
        System.debug(stuList);
        if(caseList!=null){
            insert caseList;
            System.debug(caseList);
            //idSet=new Map<Id, Case> (caseList).keySet();
            for(case csId : caseList){
                idList.add(csId.id);
            }
            for(Integer i=0;i<stuList.size();i++){
                StuList[i].Case_Number__c=idList[i];
            }
            
        }
    }
}