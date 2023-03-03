public class First_List {
    public void Method(){
    	List<String> My_List=new List<String>{'Jatin','Rohan','Arun'};
        List<String> My_List2=new List<String>{'Suresh'};
        My_List.add('Rahul');
            System.debug(My_List);
        My_List.remove(2);
          	System.debug(My_List);
        System.debug(My_List.isEmpty());
        My_List2.addAll(My_List);
        System.debug(My_List2);
        My_List2.sort();
        	System.debug(My_List2);
        My_List.clear();
        System.debug(My_List);
    }
}