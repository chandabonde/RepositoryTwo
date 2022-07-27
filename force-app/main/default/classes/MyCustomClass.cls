public class MyCustomClass {
   String x,y;
   // Provide a custom hash code
   public Integer hashCode() {
    return 
    (31*x.hashCode())^(y.hashCode());
   }
}