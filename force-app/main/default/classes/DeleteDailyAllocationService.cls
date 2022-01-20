public class DeleteDailyAllocationService {
    @InvocableMethod(label='deleteDailyAllocation')
    public static void DeleteDailyAllocation(List<Allocation__c> allocations)
    {
        Set<Id> ids= new Set<id>();
        for(Allocation__c allocation : allocations)
        	ids.add(allocation.id);
        
        DailyAllocation__c[] dailyAllocation = DeleteDailyAllocationSelector.returnsDailyAllocations(ids);
            
        if(dailyAllocation.size() > 0)
            delete dailyAllocation;  
    }
}