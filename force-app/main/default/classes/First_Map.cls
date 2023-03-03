public class First_Map {
    public void Method(){
        List<Account> Acc=[Select id,Name from Account];
        Map<Id,String> My_map=new map<Id,String>();
        for(Account accObj : Acc){
            My_map.put(accObj.Id,accObj.name);
    		System.debug(accObj.Id+'='+accObj.name+'\n');
        }
        Map<Integer,String> My_map1=new map<Integer,String>();
        My_map1.put(1,'jatin');
        My_map1.put(2,'Rohit');
        My_map1.put(3,'Rahul');
        My_map1.put(4,'Suresh');
        My_map1.put(5,'Ashok');
        System.debug(My_map1);
    }
}