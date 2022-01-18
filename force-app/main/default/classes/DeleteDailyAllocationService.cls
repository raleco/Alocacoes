public class DeleteDailyAllocationService {
    @InvocableMethod(label='deleteDailyAllocation')
    public static void DeleteDailyAllocation(List<Alocation__c> allocations)
    {
        Set<Id> ids= new Set<id>();
        for(Alocation__c allocation : allocations)
        	ids.add(allocation.id);
        
        DailyAllocation__c[] dailyAllocation = DeleteDailyAllocationSelector.returnsDailyAllocations(ids);
            
        if(dailyAllocation.size() > 0)
            delete dailyAllocation;  
    }
}