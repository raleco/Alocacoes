public class CreateDailyAllocationService {

    @InvocableMethod(label='createDailyAllocation')
    public static void createDailyAllocation (List<Alocation__c> allocations){
        
        List<DailyAllocation__c> dailyAllocation = new List<DailyAllocation__c>();
        
        for(Alocation__c all : allocations){
            DailyAllocation__c[] dailyAll = returnsAllocationCalendar(all);
            dailyAllocation.addAll(dailyAll);
        }
        
        if(dailyAllocation.size()>0) insert dailyAllocation;
    }
    
    public static List<DailyAllocation__c> returnsAllocationCalendar(Alocation__c allocation) 
    {
        List<DailyAllocation__c> dailyAllocation = new List<DailyAllocation__c>();
        DateTime startDate = DateTime.newInstance(allocation.StartDate__c, Time.newInstance(0, 0, 0, 0));
        DateTime endDate = DateTime.newInstance(allocation.EndDate__c, Time.newInstance(12, 0, 0, 0));
        
        // Holiday
        List<Holiday> holidaystb = CreateDailyAllocationSelector.returnsHolidays();
        List<date> holidays = new list<date>();
        for(holiday h : holidaystb)
            holidays.add(h.activitydate);        
        
        while (startDate <= endDate) {
            
            DailyAllocation__c dailyAll = new DailyAllocation__c();
            dailyAll.Allocation__c = allocation.Id;
            
            if (startDate.format('E') == 'Sat') startDate = startDate.addDays(2);
            else if (startDate.format('E') == 'Sun') startDate = startDate.addDays(1);
            
            dailyAll.Date__c = startDate.date();
            //dailyAll.NumberHoursDay__c = allocation.NumberHoursDay__c; //formula field
            
            if(startDate <= endDate) {
                if( ! holidays.contains(dailyAll.Date__c) )
                	dailyAllocation.add(dailyAll);
                else
                	{system.debug('Hollyday found');}
            }
            startDate = startDate.addDays(1);
        }
    	return dailyAllocation;
    }
}