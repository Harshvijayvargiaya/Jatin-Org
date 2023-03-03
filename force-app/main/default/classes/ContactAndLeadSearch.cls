public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String a){
       List<List<sObject>> searchList =[FIND :a IN ALL FIELDS
                    RETURNING Lead(FirstName,Lastname),Contact(FirstName,LastName,Department)];
        return searchList;
    }
}