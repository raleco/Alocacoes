public class DeleteDailyAllocation {
    @InvocableMethod(label='deleteDailyAllocation')
    public static void DeleteDailyAllocation(List<Alocation__c> allocations)
    {
        Set<Id> ids= new Set<id>();
        for(Alocation__c allocation : allocations)
        	ids.add(allocation.id);
        DailyAllocation__c[] dailyAllocation = 
                    [select id from DailyAllocation__c where Allocation__c in : ids ];
            
        if(dailyAllocation.size() > 0)
            delete dailyAllocation;  
    }
}