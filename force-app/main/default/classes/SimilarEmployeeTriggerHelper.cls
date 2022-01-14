public class SimilarEmployeeTriggerHelper {
     
    public static void validateDuplicateRecord(SimilarEmployeeProfile__c similarEmployeeProfile){

        List<SimilarEmployeeProfile__c> listSimilarEmployeeProfile = [
            SELECT Id
            FROM SimilarEmployeeProfile__c 
            WHERE ( SimilarEmployee__c =: similarEmployeeProfile.SimilarEmployee__c
            AND SourceEmployee__c =: similarEmployeeProfile.SourceEmployee__c ) 
            OR ( SimilarEmployee__c =: similarEmployeeProfile.SourceEmployee__c 
            AND SourceEmployee__c =: similarEmployeeProfile.SimilarEmployee__c )
        ];
        
        System.debug('listSimilarEmployeeProfile: ');
        System.debug(listSimilarEmployeeProfile);
        
        if (listSimilarEmployeeProfile.Size() > 0) {
            similarEmployeeProfile.addError('Não foi possivel salvar o registro.' + '\n' + 'Registro duplicado!');
        }
    }
    
}