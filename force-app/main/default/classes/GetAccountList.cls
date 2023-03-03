public class GetAccountList {
    public List<Account> accList{get;set;}
    public GetAccountList(){
        accList=[SELECT Name,AccountNumber,Phone FROM Account];
    }
}