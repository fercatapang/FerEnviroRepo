@isTest
private class ProcessOverviewTests {

	static testmethod void testProcessHomepageController() {	
  		Apexpages.Standardcontroller stc = new Apexpages.Standardcontroller(new LLC_BI__Loan__c());
		Process_Overview_Configuration__c p1 = new Process_Overview_Configuration__c(
  				Name = CLOSED_FUNDED,
  				Custom_Label_Key__c = CLOSED_FUNDED_LABEL,
  				Display_Order__c = 1,
  				Flow_Setting__c = false,
  				Link_URL__c = '',
  				Stage__c = CLOSED_FUNDED,
  				Active__c = true
  			);
  		insert p1;
  		
  		List<LLC_BI__Loan__c> loans = new List<LLC_BI__Loan__c>();
  		
  		LLC_BI__Loan__c loan = 
  			new LLC_BI__Loan__c (
  				Name = LOAN_NAME,
  				LLC_BI__Stage__c = WITHDRAWN,
  				LLC_BI__Lost_To__c = LOST_TO_NAME,
  				LLC_BI__CloseDate__c = Date.today()
  			);
  		loans.add(loan);
  		loan = 
  			new LLC_BI__Loan__c (
  				Name = LOAN_NAME + '1',
  				LLC_BI__Stage__c = CLOSED_FUNDED,
   				LLC_BI__CloseDate__c = Date.today()
  			);
  		loans.add(loan);
  		loan = 
  			new LLC_BI__Loan__c (
  				Name = LOAN_NAME,
  				LLC_BI__Stage__c = WITHDRAWN,
  				LLC_BI__CloseDate__c = Date.today()
  			);
  		loans.add(loan);
  		
  		insert loans;
  			
  		Test.startTest();
	  		ProcessOverviewController poc = new ProcessOverviewController(stc);
	  		String stagesJson = poc.stagesJson;
	  		String stageCountJson = poc.stageCountJson;
	  		Map<String, Integer> stageCount = (Map<String, Integer>)JSON.deserialize(stageCountJson, Map<String, Integer>.class);
	  		system.assertEquals(1,(Integer)stageCount.get(WITHDRAWN));
	  		system.assertEquals(1,(Integer)stageCount.get(CLOSED_FUNDED));
  		Test.stopTest();
	}
	
	private static final String LOAN_NAME = 'TestLoan';
	private static final String LOST_TO_NAME = 'Other Company';
	private static final String CLOSED_FUNDED = 'Closed Funded';
	private static final String CLOSED_FUNDED_LABEL = 'Closed_Funded_Label';
	private static final String WITHDRAWN = 'Withdrawn';
	private static final String WITHDRAWN_LABEL = 'Withdrawn_Label';
}