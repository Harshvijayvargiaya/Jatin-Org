@isTest
private class OpportunityStageChangeTriggerTest {
    
    static testMethod void testOpportunityStageChange() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        
        Opportunity testOpportunity = new Opportunity(
            Name='Test Opportunity',
            StageName='Prospecting',
            CloseDate=System.today(),
            AccountId=testAccount.Id
        );
        insert testOpportunity;
        
        testOpportunity.StageName = 'Closed Won';
        try {
            update testOpportunity;
            System.assert(false, 'The stage should not be changed as there are no opportunity line items');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Cannot change stage as the product is not available'), 'Unexpected error message: ' + e.getMessage());
        }
        
        OpportunityLineItem testLineItem = new OpportunityLineItem(
            OpportunityId=testOpportunity.Id,
            Quantity=1,
            TotalPrice=5000.00
            //PricebookEntryId=PricebookEntry.getStandardPricebookEntries().get(0).Id
        );
        insert testLineItem;
        
        testOpportunity.StageName = 'Closed Won';
        try {
            update testOpportunity;
        } catch (DmlException e) {
            System.assert(false, 'The stage should be changed as there is an opportunity line item: ' + e.getMessage());
        }
        
        Opportunity testOpportunity2 = new Opportunity(
            Name='Test Opportunity 2',
            StageName='Prospecting',
            AccountId=testAccount.Id
        );
        insert testOpportunity2;
        
        testOpportunity2.StageName = 'Prospecting';
        try {
            update testOpportunity2;
        } catch (DmlException e) {
            System.assert(false, 'The stage should not be changed as it is still in Prospecting: ' + e.getMessage());
        }
    }
}