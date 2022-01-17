@istest public class CreateDailyAllocationTest {
	@istest public static void CreateDailyAllocation(){
        
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
        
        //Para evitar duplicidade com o process builder visto que este teste chama o metodo invocavel diretamente
        //Também não dá problema se o PB estiver indativo na hora de passar para produção. 
        delete [select id, Date__c from DailyAllocation__c where Date__c >= :allocation.StartDate__c and Date__c <= :allocation.EndDate__c and Allocation__c = :allocation.id order by Date__c ASC];
        
        test.startTest();
        CreateDailyAllocation.CreateDailyAllocation(new List<Alocation__c>{allocation});
        test.stopTest();
        
        List<DailyAllocation__c> listDay = [select id, Date__c from DailyAllocation__c where Date__c >= :allocation.StartDate__c and date__c <= :allocation.EndDate__c and Allocation__c = :allocation.id order by date__c ASC];
        Integer workingDays = 50 - [SELECT Id FROM Holiday where ActivityDate >= :allocation.StartDate__c and ActivityDate <= :allocation.EndDate__c].size();
        system.assert(true);
        System.assertEquals(workingDays, listDay.size());//10 semanas tem 50 dias uteis tirando sabado e domingo
    }
}