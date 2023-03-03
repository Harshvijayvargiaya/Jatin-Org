@isTest
public class UpdateOutOfZipTest {
    @isTest
    static void testUpdateOutOfZip(){
        Account acc1 = new Account(Name = 'Test Account 1', BillingPostalCode = '12345');
        insert acc1;
        acc1 = [SELECT Id, Out_of_Zip__c FROM Account WHERE Id = :acc1.Id];
        System.assertEquals(false, acc1.Out_of_Zip__c);
        acc1.BillingPostalCode = '67890';
        update acc1;
        acc1 = [SELECT Id, Out_of_Zip__c FROM Account WHERE Id = :acc1.Id];
        System.assertEquals(false, acc1.Out_of_Zip__c);
        Account acc2 = new Account(Name = 'Test Account 2', BillingPostalCode = '12345');
        insert acc2;
        Contact con1 = new Contact(AccountId = acc2.Id, FirstName = 'John', LastName = 'Doe', MailingPostalCode = '12345');
        insert con1;
        acc2 = [SELECT Id, Out_of_Zip__c FROM Account WHERE Id = :acc2.Id];
        System.assertEquals(false, acc2.Out_of_Zip__c);
        acc2.BillingPostalCode = '67890';
        update acc2;
        acc2 = [SELECT Id, Out_of_Zip__c FROM Account WHERE Id = :acc2.Id];
        System.assertEquals(true, acc2.Out_of_Zip__c);
        Integer contactCount = [SELECT COUNT() FROM Contact WHERE AccountId = :acc2.Id AND MailingPostalCode != :acc2.BillingPostalCode];
        acc2.Out_of_Zip__c = (contactCount > 0);
        update acc2;
        System.assertEquals(false, acc2.Out_of_Zip__c);
    }
}