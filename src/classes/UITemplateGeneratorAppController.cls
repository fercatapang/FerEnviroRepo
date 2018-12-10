global with sharing class UITemplateGeneratorAppController {
	public UITemplateGeneratorAppController(){}

	public String getAllSObjects(){
		Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
		SObjectPOJO tempSObjectPOJO;
		List<SObjectPOJO> toReturn = new List<SObjectPOJO>();
		Schema.DescribeSObjectResult descSObj;

		for(String key : globalDescribe.keySet()){
			descSObj = globalDescribe.get(key).getDescribe();
			tempSObjectPOJO = new SObjectPOJO(
				descSObj.getLabel(),
				descSObj.getName(),
				getObjectNamespace(descSObj.getName(), descSobj.getLabel()),
				descSobj.getName().split('__c')[0].replaceFirst('__', '_')
			);
			toReturn.add(tempSObjectPOJO);
		}
		toReturn.sort();
		return LLC_BI.Utility.htmlEncodeJsonSerialize(toReturn);
	}

	@RemoteAction
	global static Map<String, Object> configureObjectForUI(String objectLabel, String objectTypeString){
		Map<String, Object> toReturn = createRoutingStructure(objectLabel, objectTypeString);
		toReturn.put(DEFAULT_APP_FIELD_EXISTS, doesDefaultAppFieldExist(objectTypeString));
		return toReturn;
	}

	@TestVisible
	private static Map<String, Object> createRoutingStructure(String objectLabel, String objectTypeString){
		String objectTypeApp = objectTypeString.split('__c')[0]
			.replaceAll('_', '-')
			.toLowerCase();
		nFORCE__Route__c route = new nFORCE__Route__c(
			Name = objectLabel + DETAILS_NAME_SUFFIX,
			nFORCE__App__c = objectTypeApp + DETAILS_APP_SUFFIX,
			nFORCE__Topbar__c = TOPBAR,
			nFORCE__Sub_Navigation__c = SUB_NAVIGATION,
			nFORCE__Navigation__c = NAVIGATION,
			nFORCE__Body__c = BLANK
		);
		nFORCE__Group__c groupSObj = new nFORCE__Group__c(
			Name = objectLabel,
			nFORCE__App__c = objectTypeApp
		);
		insert new List<SObject>{route, groupSObj};
		nFORCE__Route_Group__c[] routeGroups = new nFORCE__Route_Group__c[2];
		routeGroups[0] = new nFORCE__Route_Group__c(
			nFORCE__Route__c = route.Id,
			nFORCE__Group__c = groupSObj.Id,
			nFORCE__Parent_Route__c = route.Id,
			nFORCE__Order__c = 0
		);
		routeGroups[1] = new nFORCE__Route_Group__c(
			nFORCE__Route__c = route.Id,
			nFORCE__Group__c = groupSObj.Id,
			nFORCE__Order__c = 0
		);
		insert routeGroups;

		Map<String, Object> toReturn = new Map<String, Object>();
		toReturn.put(ROUTE_NAME, route.Name);
		toReturn.put(ROUTE_APP, route.nFORCE__App__c);
		toReturn.put(GROUP_NAME, groupSObj.Name);
		toReturn.put(GROUP_APP, groupSObj.nFORCE__App__c);

		return toReturn;
	}

	@TestVisible
	private static Boolean doesDefaultAppFieldExist(String objectTypeString){
		Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectTypeString.toLowerCase());
		Map<String, Schema.SObjectField> fieldMap = objectType.getDescribe().fields.getMap();
		Boolean defaultAppFieldExists = false;
		for(String key : fieldMap.keySet()){
			if(key.contains(DEFAULT_APP)){
				defaultAppFieldExists = true;
			}
		}
		return defaultAppFieldExists;
	}

	private String getObjectNamespace(String apiName, String objectLabel){
		String namespacePrefix = apiName.split('__')[0];
		if(namespacePrefix == apiName || namespacePrefix == apiName.split('__c')[0]){
			return '';
		}else{
			return namespacePrefix;
		}
	}

	public class SObjectPOJO implements Comparable{
		public String label;
		public String apiName;
		public String namespacePrefix;
		public String objectNameWithoutSuffix;

		public SObjectPOJO(String label, String apiName, String namespacePrefix, String objectNameWithoutSuffix){
			this.label = label;
			this.apiName = apiName;
			this.namespacePrefix = namespacePrefix;
			this.objectNameWithoutSuffix = objectNameWithoutSuffix;
		}

		public Integer compareTo(Object compareTo){
			SObjectPOJO comparedTo = (SObjectPOJO) compareTo;
			if(this.label < comparedTo.label) return -1;
			if(this.label > comparedTo.label) return 1;
			return 0;
		}
	}

	private static final String DEFAULT_APP = 'default_app',
		ROUTE_NAME = 'routeName',
		ROUTE_APP = 'routeApp',
		GROUP_NAME = 'groupName',
		GROUP_APP = 'groupApp',
		DEFAULT_APP_FIELD_EXISTS = 'defaultAppFieldExists',
		DETAILS_NAME_SUFFIX = ' Details',
		DETAILS_APP_SUFFIX = '-details',
		TOPBAR = 'nFORCE__Topbar',
		SUB_NAVIGATION = 'nFORCE__Sub_Navigation',
		NAVIGATION = 'nFORCE__Navigation',
		BLANK = 'nFORCE__Blank';
}