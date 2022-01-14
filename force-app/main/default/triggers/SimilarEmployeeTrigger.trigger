trigger SimilarEmployeeTrigger on SimilarEmployeeProfile__c (before insert) {
    new SimilarEmployeeTriggerHandler().run();
}