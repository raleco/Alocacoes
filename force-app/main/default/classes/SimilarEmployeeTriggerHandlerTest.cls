@isTest
public class SimilarEmployeeTriggerHandlerTest {
    
    static testmethod void createSimilarEmployeeProfileTest() {
        
        Employee__c newEmployee1 = new Employee__c() ;
        newEmployee1.Name = 'Test1';
        insert newEmployee1;
        
        Employee__c newEmployee2 = new Employee__c() ;
        newEmployee2.Name = 'Test2';
        insert newEmployee2;
        
        try {
            
            SimilarEmployeeProfile__c newSimilarEmployeeProfile1 = new SimilarEmployeeProfile__c();
            newSimilarEmployeeProfile1.SourceEmployee__c = newEmployee1.Id;
            newSimilarEmployeeProfile1.SimilarEmployee__c = newEmployee2.Id;
            insert newSimilarEmployeeProfile1;
            
            SimilarEmployeeProfile__c newSimilarEmployeeProfile2 = new SimilarEmployeeProfile__c();
            newSimilarEmployeeProfile2.SourceEmployee__c = newEmployee1.Id;
            newSimilarEmployeeProfile2.SimilarEmployee__c = newEmployee2.Id;
            insert newSimilarEmployeeProfile2;
            
        }catch(Exception e) {
            
            system.debug(e.getMessage());
            Boolean expectExceptionThrown = e.getMessage().contains(System.Label.DuplicateRegistryError) ? true : false;
            system.assertEquals(expectExceptionThrown, true);
            
        }
        
    }
    
}