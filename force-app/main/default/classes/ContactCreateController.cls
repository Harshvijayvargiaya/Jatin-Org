public class ContactCreateController {
    public Contact contact {
        get {
            if (contact == null)
                contact = new Contact();
            return contact;
        }
        set;
    }
    public void edit(){
    }
    public String save() {
        try {
            insert contact;
        } 
        catch (DMLException e) {
            return null;
        }
        return null;
    }
}