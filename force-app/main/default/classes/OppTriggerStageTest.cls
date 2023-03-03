@isTest
public class OppTriggerStageTest {
    @isTest
    public static void TriggerStageTest(){
        Opportunity oppObj=new Opportunity();
        Account accObj=new Account();
        oppObj.AccountId=accObj.id;
        oppObj.Name='ABC';
        oppObj.CloseDate=system.today();
        oppObj.StageName = 'Qualification';
        insert oppObj;
        oppObj.StageName = 'Closed Lost';
        Test.startTest();
            Database.SaveResult StageResult=Database.update(oppObj,false);
        Test.stopTest();
        System.assert(StageResult.isSuccess()==false,'Unable to save.');
    }
}