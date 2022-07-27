@isTest
private class CreateContactControllerTest {
    @isTest public static void TestContactAdd() {
        Account acc = new Account(Name='Test');
        Insert acc;
        List<contact> lstContacts = new List<contact>();
        for(Integer i = 0; i < 10; i++){
            lstContacts.add(new Contact(LastName='Test Contact'+i,Accountid=acc.id));
        }
        insert lstContacts;
        
        Test.StartTest(); 
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        CreateContactController contController = new CreateContactController(sc);
        
        PageReference pageRef = Page.AddContact; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        
        Test.setCurrentPage(pageRef);
        contController.con.LastName='saveContact';
        contController.saveContact();
        
        contController.back() ;
        contController.inLineEdit();
          
        contController.conWrapList[0].IsChecked= true;
        contController.deleteContact();
        
        Test.StopTest();
    }
}