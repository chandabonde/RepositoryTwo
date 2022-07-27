public class ApexConstructorClass {
    string abc;
    public ApexConstructorClass(){
    abc='xyz';
        system.debug('abc='+abc);
        
    }
    public ApexConstructorClass(string sname){
        system.debug('sname='+sname);
        
    }
}