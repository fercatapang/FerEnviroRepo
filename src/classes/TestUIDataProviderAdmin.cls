@IsTest
public with sharing class TestUIDataProviderAdmin {

	@IsTest
	public static void testRun_adminGroupExists_shouldInstallRouteAndRouteGroup(){

		insert new nFORCE__Group__c(Name = 'Admin', nFORCE__App__c = 'admin');

		Test.startTest();

		new UIDataProviderAdmin().run(false);

		Test.stopTest();

		nFORCE__Route__c route = [
			SELECT
				Id
			FROM
				nFORCE__Route__c
			WHERE
				nFORCE__App__c = 'tool-ui-template-generator'
		];
		System.assertNotEquals(route, null);

		System.assertNotEquals(
			[
				SELECT
					Id
				FROM
					nFORCE__Route_Group__c
				WHERE
					nFORCE__Route__c = :route.Id
			],
			null);
	}

	@IsTest
	public static void testRun_adminGroupDoesNotExist_shouldNotInstallRouteAndRouteGroup(){

		Test.startTest();

		new UIDataProviderAdmin().run(false);

		Test.stopTest();

		List<nFORCE__Route__c> route = [
			SELECT Id
			FROM
				nFORCE__Route__c
			WHERE
				nFORCE__App__c = 'tool-ui-template-generator'
		];
		System.assert(route.isEmpty());
	}
}