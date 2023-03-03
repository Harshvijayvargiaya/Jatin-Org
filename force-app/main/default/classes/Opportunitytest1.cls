@istest
public class Opportunitytest1 {
    @isTest
    static void Opportunitytest1(){
        /*Product2 pro = new Product2(Name = 'Test Product',Family = 'Test Family', Price__c=1223);
        insert pro;*/
        Opportunity opp = new Opportunity(Name = 'Test Opportunity',StageName = 'Prospecting',CloseDate = Date.today(),Services__c = 'Test Family');
        insert opp;
    }
}