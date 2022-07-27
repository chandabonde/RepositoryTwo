public class Covid19 {
    public integer recoveredInArea = 0;
    public static integer recoveredInCountry = 0;
    
    public Covid19(){
        system.debug('constructor called');
    }
    
    public Covid19(integer patientRecovered){
        this();
        this.recoveredInArea = patientRecovered;
        recoveredInCountry = patientRecovered;
    }
    
    public void treatPatient(){
        recoveredInArea++;  
        recoveredInCountry++;
    }
    
    public static void printTreated(){
    	system.debug('recovered in country = '+recoveredInCountry);    
    } 
}