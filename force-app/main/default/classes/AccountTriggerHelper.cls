public class AccountTriggerHelper {
    public static void BeforeTrigger(List<Account> accList){
        for(Account accObj : accList){
            if(accObj.BillingCity != null && accObj.ShippingCity == null){
                accObj.ShippingCity = accObj.BillingCity;
            }   
        }
    }
}