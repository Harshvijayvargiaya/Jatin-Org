trigger OppTriggerStage on Opportunity (before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        for(Opportunity oppObj : Trigger.New){
            Opportunity oldOpp=Trigger.OldMap.get(oppObj.id);
            if(oldOpp.StageName=='Qualification' && oppObj.StageName=='Closed Lost'){
                oppObj.addError('Unable to save.');
            }
        }
    }
}