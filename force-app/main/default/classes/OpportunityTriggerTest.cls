@isTest
public class OpportunityTriggerTest {
    @isTest
    public static void testOpportunityTrigger() {
        Account acc = new Account(Name='Test Account');
        insert acc;
        
         //List<Opportunity> stlst= new List<Opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name='Test Opportunity';
        opp.AccountId=acc.Id;
        opp.Amount=1000;
        opp.StageName='Qualification';
        opp.CloseDate=System.today();
        insert opp;
        Opportunity opp1 = new Opportunity();
        opp1.Name='Test Opportunity';
        opp1.AccountId=acc.Id;
        opp1.Amount=1000;
        opp1.StageName='Qualification';
        opp1.CloseDate=System.today();
        insert opp1;
        
        acc = [SELECT Id, Number_of_opportunities__c, Opp_amount_total__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(2, acc.Number_of_opportunities__c);
        System.assertEquals(3000, acc.Opp_amount_total__c);
    }
}