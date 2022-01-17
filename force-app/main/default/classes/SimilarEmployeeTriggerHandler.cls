public class SimilarEmployeeTriggerHandler extends TriggerHandler {

    private Map<Id, SimilarEmployeeProfile__c> newSimilarEmployeeProfileMap;
    private Map<Id, SimilarEmployeeProfile__c> oldSimilarEmployeeProfileMap;
    private List<SimilarEmployeeProfile__c> listSimilarEmployeeProfile;
    
    public SimilarEmployeeTriggerHandler() {
        this.newSimilarEmployeeProfileMap = (Map<Id, SimilarEmployeeProfile__c>) Trigger.newMap;
        this.oldSimilarEmployeeProfileMap = (Map<Id, SimilarEmployeeProfile__c>) Trigger.oldMap;
        this.listSimilarEmployeeProfile = (List<SimilarEmployeeProfile__c>) Trigger.New;
        this.setMaxLoopCount(5);
    } 
    
    public override void beforeInsert() {
        SimilarEmployeeService.validateDuplicateRecord(listSimilarEmployeeProfile[0]);
    }
}