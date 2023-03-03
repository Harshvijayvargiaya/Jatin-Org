trigger ContactPhoneTrigger on Contact(After insert,After Update){
    if((trigger.isAfter && trigger.isInsert) || (trigger.isAfter && trigger.isUpdate)){
        List<Account> accList=new List<Account>();
        for(Contact conObj:trigger.new){
            if(conObj.AccountId != null && conObj.Phone != null){
                Account accObj=new Account(phone=conObj.phone,Id=conObj.AccountId);
                accList.add(accObj);   
            }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}