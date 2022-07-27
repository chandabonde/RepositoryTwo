public class wrapperControllers {
    public list<wrapperClass>wraplist{get;set;}
    public list<contact>conlist{get;set;}
    public wrapperControllers(){
        wraplist=new list <wrapperClass>();
        conlist = new list<contact>();
        conlist=[select id, name, AccountId, Phone, Email from contact];
        for(contact con:conlist){
            wrapperClass wrp=new wrapperClass();
            wrp.conts=con;
            wraplist.add(wrp);
        }
    }
    public class wrapperClass{
        public boolean b{get;set;}
        public contact conts{get;set;}
        public wrapperClass(){
            conts=new contact();
            b=false;
        }
    }
}