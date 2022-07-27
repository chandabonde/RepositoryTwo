public class MyWrapper {
    public Contact con{get;set;}
    public boolean isChecked {get;set;}
    public MyWrapper(Contact con)
    {
        this.con=con;
        isChecked=false;
    }
}