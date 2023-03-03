public class StringArrayTest
{
    public static List<String> generateStringArray(Integer n)
    {
        List<String> L = new List<String>();
        for(Integer i =0; i < n; ++i)
            L.add('Test ' + i);
        return L;
    }
}