@istest public class DeleteDailyAllocationTest {
    @istest public static void DeleteDailyAllocation(){
        List<DailyAllocation__c> listDays;
        Integer workingDays;
        
        Employee__c employee = new Employee__c();
        employee.Name = 'Hugo da Costa';
        Insert employee;
        
        Account account = new Account();
        account.Name = 'Paulo Machado';
        insert account;
        
        Project__c project = new Project__c();
        project.Name = 'Project Hello New';
        project.Engagement__c = '123456';
        project.ResponsibleManager__c = employee.Id;
        project.ResponsibleTechnician__c = employee.Id;
        project.ResponsibleFunctional__c = employee.Id;
        project.StartDate__c = System.Date.today();
        project.EndDate__c = System.Date.today()+7;
        project.EndDateReal__c = System.Date.today()+7;
        project.TypeContract__c = 'Time Material';
        project.CostCenter__c= 'Nefeles';
        project.Status__c = 'In progress';
		insert project;
        
        Alocation__c allocation = new Alocation__c();
        allocation.Employee__c = employee.Id;
        allocation.ProjectName__c = project.Id;
        allocation.Account__c = account.id;
        allocation.StartDate__c = date.today()+5;
        allocation.EndDate__c = date.today()+74;//It will take exactly 10 weeks
        allocation.StatusAllocation__c = 'Available';
        allocation.Workload__c = 'Part-Time';
        allocation.Category__c = 'Project';
        allocation.BillingCategory__c = 'Billable';
        allocation.StatusAfterAllocation__c = 'Reserved';
        insert allocation;
        
        /* To avoid duplication with the process builder as this test calls the invoked method directly. 
		It also doesn't matter if the process builder is inactive when moving to production. */
        delete [select id from DailyAllocation__c where Allocation__c = :allocation.id];
        
        //Call the invoked method
        CreateDailyAllocation.CreateDailyAllocation(new List<Alocation__c>{allocation});
        
        //testing if everything is ok so far.
        listDays = [select id, Date__c from DailyAllocation__c where date__c >= :allocation.StartDate__c and date__c <= :allocation.EndDate__c and Allocation__c = :allocation.id order by date__c ASC];
        workingDays = 50 - [SELECT Id FROM Holiday where ActivityDate >= :allocation.StartDate__c and ActivityDate <= :allocation.EndDate__c].size();
        system.assertEquals(workingDays, listDays.size(), 'It looks like the CreateDailyAllocation method is not working as expected');//10 weeks have 50 working days apart from Saturday and Sunday
        
        allocation.StartDate__c = date.today()+16;
        allocation.EndDate__c = date.today()+92;//It will be exactly 11 weeks
        
        test.startTest();
        DeleteDailyAllocation.DeleteDailyAllocation(new List<Alocation__c>{allocation});
        test.stopTest();
        
        listDays = [select id, date__c from DailyAllocation__c where date__c >= :allocation.StartDate__c and date__c <= :allocation.EndDate__c and Allocation__c = :allocation.id order by date__c ASC];
        system.assertEquals(0, listDays.size());//0 because the method will delete everything.
    }
    
}