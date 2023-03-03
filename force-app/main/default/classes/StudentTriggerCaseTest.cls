@isTest
public class StudentTriggerCaseTest {
    @isTest
    static void testStudentTriggerCase(){
        student__c student = new student__c();
        student.Name='Student';
        student.Fee_Status__c='Defaulter';
        insert student;
        
        List<Case> cases = [SELECT Subject FROM Case WHERE Subject='Defaulter Student'];
        System.assertEquals(1, cases.size());
        
        student__c studentAfterInsert = [SELECT Case_Number__c FROM student__c WHERE Id =: student.Id];
        System.assertNotEquals(null, studentAfterInsert.Case_Number__c);
    }
}