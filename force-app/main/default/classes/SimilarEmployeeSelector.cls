public inherited sharing class SimilarEmployeeSelector {
    
    public static List<SimilarEmployeeProfile__c> getDuplicateListSimilarEmployeeProfile(SimilarEmployeeProfile__c similarEmployeeProfile) {

        return [SELECT Id,
                SimilarEmployee__c,
                SourceEmployee__c,
                Function__c
                FROM SimilarEmployeeProfile__c 
                WHERE ( SimilarEmployee__c =: similarEmployeeProfile.SimilarEmployee__c
                       AND SourceEmployee__c =: similarEmployeeProfile.SourceEmployee__c ) 
                OR ( SimilarEmployee__c =: similarEmployeeProfile.SourceEmployee__c 
                    AND SourceEmployee__c =: similarEmployeeProfile.SimilarEmployee__c )
        ];
    }
}