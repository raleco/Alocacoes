public class DeleteDailyAllocationSelector {
    public static List<DailyAllocation__c> returnsDailyAllocations(Set<Id> ids){
        return [select id from DailyAllocation__c where Allocation__c in : ids ];
    }
}