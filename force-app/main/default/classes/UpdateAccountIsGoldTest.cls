@isTest
public class UpdateAccountIsGoldTest {
    @isTest
    static void testUpdateAccountIsGold() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Opportunity opp1 = new Opportunity(AccountId = acc.Id, Name = 'Test Opportunity 1', Amount = 10000 , StageName ='Check',CloseDate = System.today(),Services__c='Fixed');
        insert opp1;
        acc = [SELECT Id, Is_gold__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(false, acc.Is_gold__c);
        Opportunity opp2 = new Opportunity(AccountId = acc.Id, Name = 'Test Opportunity 2', Amount = 25000, StageName ='Check',CloseDate = System.today(),Services__c='Fixed');
        insert opp2;
        acc = [SELECT Id, Is_gold__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(true, acc.Is_gold__c);
    }
}