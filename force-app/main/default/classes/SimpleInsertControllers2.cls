public class SimpleInsertControllers2 {
    public Contact con {get;set;}  
    public List<Contact> cont {get;set;} //for List of Contact
    public List<MyWrapper> lstwrap{get;set;}
    public string conid{get;set;}
    
    public SimpleInsertControllers2(ApexPages.StandardController controllers)
    {
        con = new Contact();  //(object creation) will intialize the fields as empty
        lstWrap=new List<MyWrapper>();
        loadPage(); 
    }
    public void loadPage() // to refresh the page
    {
        cont = [select FirstName,LastName,AccountId,Title,Email,Phone from Contact order by createdDate desc];
        lstWrap.clear();
        for(Contact a : cont){
            lstWrap.add(new MyWrapper(a));
        }
    }
    public PageReference saveContact() // to refer page
    {
        Database.UpsertResult sr= Database.upsert(con,false);// my contact got created(single result)
        if(sr.isSuccess())
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,
                                                       'Contact Inserted Succesfully')); //page messeage
            con =new Contact(); //reasign
            loadPage();
        }
        else{
            List<Database.Error> errs = sr.getErrors();
            for(Database.Error er : errs)
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,
                                                           'Error'+er.getMessage()));
            }
        }
        return null; // will return on same page..(If void is use in method then it is not require)
    }
  Public pagereference back() {
      Pagereference pg = new Pagereference ('https://damco42-dev-ed.lightning.force.com/lightning/o/Account/list?filterName=Recent');
pg.setRedirect (true);
return pg;
}
    public void editContact()
    {
        con = [select FirstName,LastName,AccountId,Title,Email,Phone from Contact where id = :conid];
    }
    public void deleteContact()
    {
        List<Contact> conToBeDel = new List<Contact>();
        for(MyWrapper mr : lstwrap)
        {
            if(mr.isChecked)
            {
                conToBeDel.add(mr.con);
            }
        }
        List<Database.DeleteResult> dr = Database.delete(conToBeDel,false);
        for(Database.DeleteResult d : dr)
        {
            if(d.isSuccess())
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,
                                                           ' CONTACT Deleted Succesfully'));
                loadPage();
            }
            else{
                List<Database.Error> errs = d.getErrors();
                for(Database.Error er : errs)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,
                                                               'Error'+er.getMessage()));
                }
            }
        }
    }
}