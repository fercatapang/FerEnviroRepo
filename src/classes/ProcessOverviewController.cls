global with sharing class ProcessOverviewController {
	private static final String WITHDRAWN = 'Withdrawn';
	public String stageCountJson {get; set;}
	public String stagesJson {get; set;}
	public List<Process_Overview_Configuration__c> stages {get; set;}
	
	// This constructor is here for the test drivers
	public ProcessOverviewController() {
		setupData();
	}
    public ProcessOverviewController(ApexPages.StandardController stdController) {
    	setupData();
    }
    private void setupData(){
    	List<String> stageNames = new List<String>();
    	Map<String, Integer> stageCount = new Map<String, Integer>();
		stages = getProcessConfig();

		for(Process_Overview_Configuration__c c : stages){
			stageNames.add(c.Stage__c);
			stageCount.put(+c.Stage__c, 0);
		}

		List<aggregateResult> results = [
			SELECT 
				count(Id) counter, 
				LLC_BI__Stage__c stage 
			FROM 
				LLC_BI__Loan__c 
			WHERE 
				((LLC_BI__Stage__c !=: WITHDRAWN) 
				OR 
				((LLC_BI__Stage__c =: WITHDRAWN) AND (LLC_BI__Lost_To__c != null)))
			group by 
				LLC_BI__Stage__c];
		
		for (AggregateResult ar : results) {
			stageCount.put((String)ar.get('stage'), (Integer)ar.get('counter'));
		}
				
		stageCountJson = JSON.serialize(stageCount);
		stagesJson = JSON.serialize(stages);
    }
    
    private Process_Overview_Configuration__c[] getProcessConfig(){
    	return [
    		SELECT 
    			Name, 
    			Stage__c, 
    			Custom_Label_Key__c, 
    			Link_URL__c, 
    			IconImageName__c, 
    			IconStyleClass__c, 
    			Flow_Setting__c, 
    			StaticResourceName__c
    		FROM 
    			Process_Overview_Configuration__c
    		WHERE 
    			Active__c = true
    		order by 
    			Active__c, 
    			Display_Order__c
    		];
    }
}