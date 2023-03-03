@isTest
public class StudentTriggerTest {
    @isTest
    public static void StudentTrigger(){
        Class__C cls = new Class__c();
        cls.Name = '3rd';
        insert cls;
        
        List<Student__c> stlst= new List<Student__c>();
        
        Student__c st = new Student__c();
        st.Name = 'Pankaj';
        st.class__c = cls.Id;
        stlst.add(st);
        
        Student__c st1 = new Student__c();
        st1.Name = 'Rohit';
        st1.class__c = cls.Id;
        stlst.add(st1);
        
        Student__c st2 = new Student__c();
        st2.Name = 'Om';
        st2.class__c = cls.Id;
        stlst.add(st2);
        
        Student__c st3 = new Student__c();
        st3.Name = 'Jatin';
        st3.class__c = cls.Id;
        stlst.add(st3);
        
        Student__c st4 = new Student__c();
        st4.Name = 'Jatin';
        st4.class__c = cls.Id;
        stlst.add(st4);
        
        Student__c st5 = new Student__c();
        st5.Name = 'Rahul';
        st5.class__c = cls.Id;
        stlst.add(st5);
        
        Student__c st6 = new Student__c();
        st6.Name = 'Pankaj';
        st6.class__c = cls.Id;
        stlst.add(st6);
        
        Student__c st7 = new Student__c();
        st7.Name = 'Rohit';
        st7.class__c = cls.Id;
        stlst.add(st7);
        
        Student__c st8 = new Student__c();
        st8.Name = 'Om';
        st8.class__c = cls.Id;
        stlst.add(st8);
        
        
        //insert stlst;   
        //stlst= new List<Student__c>();
        
        Student__c st9 = new Student__c();
        st9.Name = 'Jatin';
        st9.class__c = cls.Id;
        stlst.add(st9);
        
        Student__c st10 = new Student__c();
        st10.Name = 'pawan';
        st10.class__c = cls.Id;
        stlst.add(st10);   
        
        Student__c st11 = new Student__c();
        st11.Name = 'rohan';
        st11.class__c = cls.Id;
        stlst.add(st11); 
        
        insert stLst;
        
        stlst= new List<Student__c>();
        
        Student__c st12 = new Student__c();
        st12.Name = 'Jatin';
        st12.class__c = cls.Id;
        stlst.add(st12);
        
        Student__c st13 = new Student__c();
        st13.Name = 'pawan';
        st13.class__c = cls.Id;
        stlst.add(st10);   
        
        Student__c st14 = new Student__c();
        st14.Name = 'rohan';
        st14.class__c = cls.Id;
        stlst.add(st14); 
        
        Student__c st16 = new Student__c();
        st16.Name = 'rohan';
        st16.class__c = cls.Id;
        stlst.add(st16); 
        
        Student__c st17 = new Student__c();
        st17.Name = 'rohan';
        st17.class__c = cls.Id;
        stlst.add(st17); 
        
        try {
            insert stLst;
            System.assert(false, 'error');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('You can not add more than 10 students in a single class.'));
        }
    }
}