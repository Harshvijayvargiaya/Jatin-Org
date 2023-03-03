@isTest
public class OrderTriggerKrowTest {
    @isTest
    static void testOrderActivation() {
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Contract CC = New Contract();
        CC.Accountid = acc.id;
        CC.Status = 'Draft';
        CC.StartDate = Date.today();
        CC.ContractTerm = 2;
        Insert CC;
        CC.Status = 'Activated';
        update CC;
        
        Opportunity opp = new Opportunity(Name='Test Opportunity', StageName='Prospecting', CloseDate=Date.today(), AccountId=acc.Id,Services__c='test');
        insert opp;
        Product2 prod = new Product2(Name = 'Laptop X200', 
                                     Family = 'Hardware',price__c=120);
        insert prod;
        
        Id pricebookId = Test.getStandardPricebookId();
        
        PricebookEntry standardPrice = new PricebookEntry(
            Pricebook2Id = pricebookId, Product2Id = prod.Id,
            UnitPrice = 10000, IsActive = true);
        insert standardPrice;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        PricebookEntry customPrice = new PricebookEntry(
            Pricebook2Id = customPB.Id, Product2Id = prod.Id,
            UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        Krow_Project__c kc = new Krow_Project__c();
        kc.Onboarding_Type__c='Template';
        insert kc;
        Krow_Task__c ktc = new Krow_Task__c();
        ktc.Krow_project__c=kc.Id;
        insert ktc;
        
        Order ord = new Order(Name='Test Order', EffectiveDate=Date.today(), Status='Draft', AccountId=acc.Id, OpportunityId=opp.Id,contractid=CC.id,Pricebook2Id = customPB.Id);
        insert ord;
        OrderItem oi = new OrderItem(OrderId=ord.Id, PricebookEntryId=customPrice.Id, 
                                     Quantity=2, UnitPrice=100.00, Product2Id = prod.Id);
        insert oi;
        ord.OrderItems.add(oi);
        opp.StageName = 'Signature';
        update opp;
        ord.Status = 'Activated';
        update ord;
        
        List<Krow_Project__c> krowProjects = [SELECT Id, Onboarding_Type__c FROM Krow_Project__c WHERE Order__c = :ord.Id];
        System.assertEquals(1, krowProjects.size());
        System.assertEquals('Installation', krowProjects[0].Onboarding_Type__c);
        System.debug(krowProjects);
        
        List<Krow_Task__c> krowTasks = [SELECT Id,Name,Status__c FROM Krow_Task__c WHERE Krow_Project__r.isTemplateKrow__c=true];
        System.assertNotEquals(0, krowTasks.size());
        
        try {
            update ord;
            System.assert(false, 'Expected error did not occur');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Cannot mark Order as Completed if Opportunity Stage is not Signature.'));
        }
    }
}