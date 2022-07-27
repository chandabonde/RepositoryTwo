public class InvoicePage {

    public String retURL {get; set;}
    public String saveNewURL {get; set;}
    public String rType {get; set;}
    public String modeType {get; set;}
    public ApexPages.StandardController sCtrl;
    
    public InvoicePage(ApexPages.StandardController controller) {
        this.sCtrl = controller;
        retURL = ApexPages.currentpage().getParameters().get('retURL');
        rType = ApexPages.currentPage().getParameters().get('International Sales Coaching Note');
        String recordId = ApexPages.currentpage().getParameters().get('Id');
        if(String.isBlank(recordId)){
            modeType = 'Edit';
        }else{
            modeType = 'Detail';
        }
    }
    
    public pageReference save(){
        this.sCtrl.save();        
        String recordId = ApexPages.currentpage().getParameters().get('Id');
        pageReference rPage = null;
        if(!String.isBlank(recordId)){
            rPage = new pageReference('/'+recordId);
        }
        modeType = 'Detail';
        return rPage;
    }
    
    public pageReference openEditView(){
        modeType = 'Edit';
        return null;
    }
    
    public PageReference redirect() {
        PageReference returnURL;
        // Redirect if Record Type corresponds to custom VisualForce page
        IF(rType == 'International Sales Coaching Note') {
              returnURL = new PageReference('/apex/Sales_Coaching_Note__c');
        }
        return returnURL;
    }
}