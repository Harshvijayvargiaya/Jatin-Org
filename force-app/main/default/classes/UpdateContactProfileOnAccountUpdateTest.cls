@isTest
public class UpdateContactProfileOnAccountUpdateTest {
    @isTest
    static void testUpdateContactProfileOnAccountUpdate() {
        Account acc = new Account(Name = 'Test Account', Website = 'www.google.com');
        insert acc;
        Contact con = new Contact(AccountId = acc.Id, FirstName = 'John', LastName = 'Doe');
        insert con;
        acc.Website = 'www.google.com';
        update acc;
        con = [SELECT Id, Profile__c FROM Contact WHERE Id = :con.Id];
        System.assertEquals('www.google.com/JDoe', con.Profile__c);
    }
}