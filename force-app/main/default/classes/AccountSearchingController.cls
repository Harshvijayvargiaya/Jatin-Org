public class AccountSearchingController{
    public String getAccName{get;set;}
    public List<Account> accList{get;set;}
    public AccountSearchingController(){
        accList=[SELECT Name,AccountNumber,Phone FROM Account];            
    }
    public void getAccountName(){
        if(getAccName!=''){
            accList=[SELECT Name,AccountNumber,Phone FROM Account WHERE Name Like:'%'+getAccName+'%'];            
        }
    }
}