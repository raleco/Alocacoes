public class SimilarEmployeeService {
     
    public static void validateDuplicateRecord(SimilarEmployeeProfile__c similarEmployeeProfile) {

        List<SimilarEmployeeProfile__c> listSimilarEmployeeProfile = SimilarEmployeeSelector.getDuplicateListSimilarEmployeeProfile(similarEmployeeProfile);
        
        System.debug('listSimilarEmployeeProfile: ');
        System.debug(listSimilarEmployeeProfile);
        
        if (listSimilarEmployeeProfile.Size() > 0) { 
            similarEmployeeProfile.addError(System.Label.DuplicateRegistryError);
        }
    }
    
}