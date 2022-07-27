public class InvoiceController {
    private final Order order;
    private final List<OrderItem> orderItems;
    
    public InvoiceController(){
        Order = [select Id,OrderNumber,TotalAmount,  Total_Amount__c, Discount__c, AccountId from order];
        orderItems = [select Product2Id, UnitPrice, Quantity, TotalPrice from orderItem];
    }
    public Order gerOrder(){
        return Order;
    }
    public List<OrderItem> getOrderItems(){
        return orderItems;
    }

}