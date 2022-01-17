public class CreateDailyAllocationSelector {
    public static list<Holiday> returnsHolidays(){
       return [Select activitydate From Holiday];
    }
}