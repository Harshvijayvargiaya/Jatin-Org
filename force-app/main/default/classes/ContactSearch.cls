public class ContactSearch {
    public static List<Contact> searchForContacts(String a,String b){
        List<Contact> c=[Select Id,Name from Contact where LastName=:a AND MailingPostalCode=:b];
            return c;
    } 
}