public class company {
	public string companyName;
    public string ceo;
    public integer employeeCount;
    public long revenue;
    
    private list<client> customers = new list<client>();
    
    public void addNewCustomer(string Name, string website, string email, long phone){
        client customer = new client(Name, website, email, phone);
        customers.add(customer);    
    }
    public void getAllCustomers(){
        for(client customer:customers ){
            System.debug('Customer Name: '+customer.clientName+', Website: '+customer.website+', Email: '+customer.email+', Phone: '+customer.phone);
        }
    }
    public class client{
        public string clientName;
        public string website;
        public string email;
        public long phone;
        
        public client(string clientName, string website, string email, long phone){
        	this.clientName = clientName;
        	this.website = website;
            this.email = email;
            this.phone = phone;
        }
    }
}