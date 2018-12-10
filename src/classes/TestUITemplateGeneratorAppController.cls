@IsTest
public with sharing class TestUITemplateGeneratorAppController {

	@IsTest
	public static void testGetAllSObjects_returnsSortedListOfSObjects(){

		Test.startTest();

		UITemplateGeneratorAppController ctrl = new UITemplateGeneratorAppController();
		List<UITemplateGeneratorAppController.SObjectPOJO> sObjectList =
			(List<UITemplateGeneratorAppController.SObjectPOJO>) JSON.deserialize(ctrl.getAllSObjects(), List<UITemplateGeneratorAppController.SObjectPOJO>.class);

		Test.stopTest();

		System.assertEquals(Schema.getGlobalDescribe().keySet().size(), sObjectList.size());
		UITemplateGeneratorAppController.SObjectPOJO tempSObjectPOJO;
		for(Integer i = 1; i < sObjectList.size(); i++){
			System.assert(sObjectList.get(i).label > sObjectList.get(i - 1).label || sObjectList.get(i).label == sObjectList.get(i - 1).label);
		}
	}

	@IsTest
	public static void testCreateRouteStructure_ReturnsMapWithRouteConfig(){

		Test.startTest();

		Map<String, Object> returned = UITemplateGeneratorAppController.createRoutingStructure('a label', 'an api name');

		Test.stopTest();

		System.assertEquals(4, returned.size());
		nFORCE__Route__c route = [
			SELECT
				Id,
				Name,
				nFORCE__App__c
			FROM
				nFORCE__Route__c
			LIMIT 1
		];
		nFORCE__Group__c group1 = [
			SELECT
				Id,
				Name,
				nFORCE__App__c
			FROM
				nFORCE__Group__c
			LIMIT 1
		];
		System.assertEquals((String) returned.get('routeName'), route.Name);
		System.assertEquals((String) returned.get('routeApp'), route.nFORCE__App__c);
		System.assertEquals((String) returned.get('groupName'), group1.Name);
		System.assertEquals((String) returned.get('groupApp'), group1.nFORCE__App__c);
		System.assertEquals(2, [SELECT COUNT() FROM nFORCE__Route_Group__c]);
	}

	@IsTest
	public static void testDoesDefaultAppFieldExist_ObjectIsLoan_ReturnsTrue(){

		Test.startTest();

		Boolean returned = UITemplateGeneratorAppController.doesDefaultAppFieldExist('LLC_BI__Loan__c');

		Test.stopTest();

		System.assertEquals(returned, true);
	}

	@IsTest
	public static void testDoesDefaultAppFieldExist_ObjectIsDeposit_ReturnsFalse(){

		Test.startTest();

		Boolean returned = UITemplateGeneratorAppController.doesDefaultAppFieldExist('LLC_BI__Deposit__c');

		Test.stopTest();

		System.assertEquals(returned, false);
	}
}