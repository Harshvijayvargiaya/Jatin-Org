@isTest
public class OppTriggerKrowTest {
    @isTest
    static void testOppTriggerKrow() {
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Services__c='test'
        );
        insert opp;
        List<Krow_Project__c> krowsBefore = [SELECT Id, Onboarding_Type__c, Opportunity__c FROM Krow_Project__c];
        System.assertEquals(0, krowsBefore.size());
        
        opp.StageName = 'Signature';
        update opp;
        List<Krow_Project__c> krowsAfter = [SELECT Id, Onboarding_Type__c,Opportunity__c FROM Krow_Project__c];
        System.assertEquals(1, krowsAfter.size());
        System.assertEquals('Customer Onboarding', krowsAfter[0].Onboarding_Type__c);
        System.assertEquals(opp.Id, krowsAfter[0].Opportunity__c);
    }
}