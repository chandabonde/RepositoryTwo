public class InvoicePage2 {
    public string OrderId {set; get;}
    public InvoicePage2 (ApexPages.StandardController controller) {
    	OrderId=ApexPages.currentPage().getParameters().get('Id');
    }    
public void attachpdf() {
    boolean flag=false;
    if(flag==false){
	Attachment myAttach= new Attachment();
	myAttach.ParentId =OrderId;//Id of the object to which the page is attached 
    myAttach.name = 'order.pdf';
	PageReference myPdf =ApexPages.currentPage();//myPdfPage is the name of your pdf page
	system.debug('PDF >>>>'+mypdf);
    myAttach.body =myPdf.getContentAsPdf(); 
    insert myAttach;
	}
}
}