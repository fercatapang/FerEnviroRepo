@isTest
public class TestCSA_RiskRatingConfigController {
	
	@isTest
	public static void isInstalledFalse() {
		CSA_RiskRatingConfigurationController RRCC = new CSA_RiskRatingConfigurationController();

		Test.startTest();

		RRCC.getIsInstalled();

		Test.stopTest();
	}

	@isTest
	public static void isInstalledTrue() {
		LLC_BI__System_Properties__c testSystemProperty = createSystemProperty();
		CSA_RiskRatingConfigurationController RRCC = new CSA_RiskRatingConfigurationController();

		Test.startTest();

		RRCC.getIsInstalled();

		Test.stopTest();
	}

	@isTest
	public static void install() {
		CSA_RiskRatingConfigurationController RRCC = new CSA_RiskRatingConfigurationController();

		Test.startTest();

		RRCC.install();

		Test.stopTest();
	}

	@isTest
	public static void uninstall() {
		CSA_RiskRatingConfigurationController RRCC = new CSA_RiskRatingConfigurationController();

		Test.startTest();

		RRCC.uninstall();

		Test.stopTest();
	}

	@isTest
	public static void finish() {
		CSA_RiskRatingConfigurationController RRCC = new CSA_RiskRatingConfigurationController();

		Test.startTest();

		RRCC.finish();

		Test.stopTest();
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