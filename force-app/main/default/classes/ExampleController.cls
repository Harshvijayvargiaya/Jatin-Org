public class ExampleController {
    public List<Opportunity> oppList{get;set;}
    public ExampleController(){
       oppList = [SELECT Name,Account.Name,Amount,CloseDate FROM Opportunity WHERE Amount < 100000 LIMIT 10];
    }
    public Boolean isOpp(){
        Boolean isExist = false;
            if(oppList.size() > 0){
                isExist = true;
            }
        return isExist;
    }
}