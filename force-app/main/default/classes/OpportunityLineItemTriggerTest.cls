@isTest
public class OpportunityLineItemTriggerTest {
    @isTest
    static void OpportunityLineItemTrigger(){
        Product2 pro = new Product2(
            Name = 'Test Product',
            Family = 'Test Family',
            Price__c=123.23
        );
        insert pro;
        
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Test StageName',
            CloseDate = Date.today(),
            Services__c = 'Test Family'
        );
        insert opp;
        
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = opp.Id,
            Product2Id = pro.Id,
            Quantity = 1,
            PricebookEntryId = Test.getStandardPriceBookId()
        );
        Test.startTest();
        insert oli;
        Test.stopTest();
        
        List<OpportunityLineItem> oliList = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId = :opp.Id];
        System.assertEquals(1, oliList.size());
    }
}