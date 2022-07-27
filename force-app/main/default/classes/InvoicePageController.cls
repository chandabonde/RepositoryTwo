public class InvoicePageController {
    Public static Map<String,list<SObject>> getOrder(Id orderId){
        Map<String,list<SObject>> resultMap = New Map<String,list<SObject>>();
    	list<OrderItem> orderItemList =[ select Id, Order.Total_Amount__c, Order.TotalAmount, Order.Discount__c, Order.AccountId, Product2.Name, Product2.ProductCode from OrderItem];
   		resultMap.put('OrderItemRecord', orderItemList);
        return resultMap;
    }
}