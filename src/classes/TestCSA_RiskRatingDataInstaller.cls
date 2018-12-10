@isTest
public class TestCSA_RiskRatingDataInstaller {
	
	@isTest
	public static void testInstallScript() {
		CSA_RiskRatingDataInstaller dataInstaller = new CSA_RiskRatingDataInstaller();
		Test.testInstall(dataInstaller, null);
	}

	@isTest
	public static void uninstall() {
		nForce__Group__c testGroup = createGroup();
		nForce__Route__c testRoute = createRoute();
		nFORCE__Route_Group__c testRouteGroup = createRouteGroup(testGroup.Id, testRoute.Id);
		LLC_BI__System_Properties__c testSystemProperty = createSystemProperty();
		Test.testUninstall(new CSA_RiskRatingDataInstaller());
	}

	private static nForce__Group__c createGroup() {
		nForce__Group__c newG = new nForce__Group__c(
			Name = 'Test createGroup',
			nFORCE__App__c = 'Test');

		Database.insert(newG);
		return newG;
	}

	private static nForce__Route__c createRoute() {
		nForce__Route__c newR = new nForce__Route__c(
			Name = 'Risk Rating Selection',
			nFORCE__Body__c = 'c__CSA_LoanAccountRiskRating',
			nForce__App__c = 'risk-rating-selector',
			nFORCE__Navigation__c = 'nforce__navigation',
			nFORCE__Sub_Navigation__c = 'nforce__sub_navigation',
			nFORCE__Topbar__c = 'nforce__topbar');

		Database.insert(newR);
		return newR;
	}

	private static nFORCE__Route_Group__c createRouteGroup(Id groupId, Id routeId) {
		nFORCE__Route_Group__c newRG = new nFORCE__Route_Group__c(
			nFORCE__Group__c = groupId,
			nFORCE__Route__c = routeId,
			nFORCE__Order__c = 0);

		Database.insert(newRG);
		return newRG;
	}

	private static LLC_BI__System_Properties__c createSystemProperty() {
		LLC_BI__System_Properties__c newSP = new LLC_BI__System_Properties__c(
			Name = '123456789987645321132',
			LLC_BI__Category_Name__c = 'CSA Risk Rating Selector',
			LLC_BI__Is_Active__c = true,
			LLC_BI__Key__c = 'Risk Rating Data Installer',
			LLC_BI__Value__c = 'true');

		Database.insert(newSP);
		return newSP;
	}
}