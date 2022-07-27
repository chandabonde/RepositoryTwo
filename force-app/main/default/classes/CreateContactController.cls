public class CreateContactController {
    public contact con {get;set;}
    public list<ContactWrapper> conWraplist {get;set;}
    public map<id,ContactWrapper> conWrapMap {get;set;}
    ApexPages.StandardController sc;
    
    public CreateContactController(ApexPages.StandardController sc){
        con=new contact();
        this.sc=sc;
        if(conWrapMap==null){
            conWrapMap= new map<id,ContactWrapper>();
            for(contact con:[select id, FirstName, LastName, MobilePhone, Title, Email, AccountId from contact where accountId =: sc.getId()]){
                ContactWrapper wrap=new ContactWrapper(con,sc);
                conWrapMap.put(wrap.con.Id, wrap);
            }
        }
        addconWraplist();
    }
    public void addconWraplist(){
        conWraplist = conWrapMap.values();
    }
    public void saveContact(){
        con.AccountId = ApexPages.currentPage().getParameters().get('id');
        database.SaveResult sr=database.insert(con,false);
        if(sr.isSuccess()){
            con.id=sr.getId();
            conWrapMap.put(con.id, new contactWrapper(con,sc));
            addconWraplist();
        }
        else{
            for(database.Error err:sr.getErrors()){
                system.debug('contact field that affected this error:'+err.getFields());
            }
        }
        con=new contact();
    }
    public pageReference back(){
        pageReference pg= new pageReference('/'+ApexPages.currentPage().getParameters().get('id'));
        pg.setRedirect(true);
        return pg;
    }
    public void inLineEdit(){
        list<contact> contactlist = new list<contact>();
        for(contactWrapper cw:conWrapList){
            contactList.add(cw.con);
        }
        database.SaveResult[]srlist=database.update(contactlist,false);
        for(database.SaveResult sr :srlist){
            if(sr.isSuccess ()){
                conWrapMap.put(sr.getId(),conWrapMap.get(sr.getId()));
            }
            else{
                for(database.error err:sr.geterrors()){
                    system.debug(err.getStatusCode()+':'+err.getMessage());
                    system.debug('contact fields that affected this error'+err.getFields());
                }
            }
        }
        addconWraplist();
    }
    public void deleteContact(){
        list<contact>contactlist=new list<contact>();
        for(contactWrapper cw:conWrapList){
            if(cw.IsChecked==true){
                contactlist.add(cw.con);
            }
        }
        database.DeleteResult[] drlist =database.delete(contactList);
        for(database.DeleteResult dr : drlist){
            if(dr.issuccess()){
                conWrapMap.remove(dr.getId());
                addconWraplist();
            }
            else{
                for(database.Error err:dr.getErrors()){
                    system.debug(err.getStatusCode()+':'+err.getMessage());
                    system.debug('contact field that affected this error:'+err.getFields());
                }
            }
        }
    }
    public class ContactWrapper{
        public contact con{get;set;}
        public boolean IsChecked {get;set;}
        public ContactWrapper(contact cont,apexPages.StandardController sc){
            con=cont;
            cont.accountId=sc.getId();
        }
    }
}