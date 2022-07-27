public class SimpleInsertControllers {
    public Contact Con {get;set;}  //sobject
    public List<Contact> accs {get;set;} //for List of Contact
    public List<MyWrapper> lstwrap{get;set;}
    public string acid{get;set;}
    
    public SimpleInsertControllers(ApexPages.StandardController controllers)
    {
        Con = new Contact();  //object creation will intialize the fields..as empty
        lstWrap=new List<MyWrapper>();
        loadPage(); 
    }
    public void loadPage() // to refresh the page
    {
        accs = [select FirstName,LastName,AccountId,Title,Email,Phone from Contact order by createdDate desc];
        lstWrap.clear();
        for(Contact a : accs){
            lstWrap.add(new MyWrapper(a));
        }
    }
    public PageReference saveContact() // to refere page(Void can be use)
    {
        Database.UpsertResult sr= Database.upsert(Con,false);// my contact got created(single result)
        if(sr.isSuccess())
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,
                                                       'Contact Inserted Succesfully')); //page messeage
            Con =new Contact(); //reasign
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
      Pagereference pg = new Pagereference ('https://mtech26-dev-ed.lightning.force.com/lightning/o/Account/list?filterName=Recent');
pg.setRedirect (true);
return pg;
}
    public void editContact()
    {
        Con = [select FirstName,LastName,AccountId,Title,Email,Phone from Contact where id = :acid];
    }
    public void deleteContact()
    {
        List<Contact> accToBeDel = new List<Contact>();
        for(MyWrapper mr : lstwrap)
        {
            if(mr.isChecked)
            {
                accToBeDel.add(mr.Con);
            }
        }
        List<Database.DeleteResult> dr = Database.delete(accToBeDel,false);
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