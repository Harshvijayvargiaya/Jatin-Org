public class sObjectDemo {
    public void Method(){
        sObject obj =new Account(Name='Jatin',Phone='706241535577');
    	Account acc=(Account)obj;
    System.debug('Account = '+acc);
    }
}