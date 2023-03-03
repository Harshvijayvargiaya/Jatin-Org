@isTest
public class OpportunityDocumentUploadTriggerTest {
@isTest
    static void testTrigger() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate=System.today();
        insert opp;
        opp = [SELECT Document_Upload__c FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(true, opp.Document_Upload__c);
    }
}