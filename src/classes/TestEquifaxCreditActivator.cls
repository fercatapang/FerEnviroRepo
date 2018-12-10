@isTest
private class TestEquifaxCreditActivator {

	@TestSetup
	static void setup() {
		new nFUSE.DataInstaller().onInstall(null);
	}

	@isTest
	private static void testActivation_onActivate_registersBean() {
		EquifaxCreditAppFacade bean = retrieveBean();
		System.assertEquals(null, bean);
		Test.startTest();
		new EquifaxCreditActivator().onActivate();
		Test.stopTest();
		bean = retrieveBean();
		System.assertNotEquals(null, bean);
	}

	@isTest
	private static void testActivation_onActivate_installProperties() {
		Test.startTest();
		new EquifaxCreditActivator().onActivate();
		Test.stopTest();

		nFUSE.PluginConfigurationManager configManager = new nFUSE.PluginConfigurationManager(EquifaxCreditAppFacade.PLUGIN_NAME, EquifaxCreditAppFacade.PLUGIN_VERSION);
		List<nFUSE.PluginConfigurationManager.PluginConfiguration> configs = configManager.getConfigurations();

		List<String> keysToCheck = expectedProperties.clone();
		System.assertEquals(17, keysToCheck.size());
		for(nFUSE.PluginConfigurationManager.PluginConfiguration currentConfig : configs) {
			removeValueFromList(keysToCheck, currentConfig.key);
		}
		System.assertEquals(0, keysToCheck.size());
	}

	@isTest
	private static void testActivation_onActivateTwice_installProperties() {
		Test.startTest();
		EquifaxCreditActivator act = new EquifaxCreditActivator();
		act.onActivate();
		act.onDeactivate();
		act.onActivate();
		Test.stopTest();

		nFUSE.PluginConfigurationManager configManager = new nFUSE.PluginConfigurationManager(EquifaxCreditAppFacade.PLUGIN_NAME, EquifaxCreditAppFacade.PLUGIN_VERSION);
		List<nFUSE.PluginConfigurationManager.PluginConfiguration> configs = configManager.getConfigurations();

		List<String> keysToCheck = expectedProperties.clone();
		System.assertEquals(17, keysToCheck.size());
		for(nFUSE.PluginConfigurationManager.PluginConfiguration currentConfig : configs) {
			removeValueFromList(keysToCheck, currentConfig.key);
		}
		System.assertEquals(0, keysToCheck.size());
	}

	private static void removeValueFromList(List<Object> theList, Object theValue) {
		for(Integer i = 0; i < theList.size(); i++) {
			if(theList.get(i) == theValue) {
				theList.remove(i);
				return;
			}
		}
	}

	private static EquifaxCreditAppFacade retrieveBean() {
		return (EquifaxCreditAppFacade) nFORCE.BeanFactory.getInstance().getBeanByUniqueName(
			EquifaxCreditAppFacade.class.getName()
		);
	}

	private static List<String> expectedProperties = new List<String> {
		EquifaxCreditActivator.CONSUMER_USER_SITE_ID,
		EquifaxCreditActivator.CONSUMER_PASSWORD,
		EquifaxCreditActivator.CONSUMER_CUSTOMER_CODE,
		EquifaxCreditActivator.CONSUMER_SOFT_MEMBER_NUMBER,
		EquifaxCreditActivator.CONSUMER_SOFT_SECURITY_CODE,
		EquifaxCreditActivator.CONSUMER_HARD_MEMBER_NUMBER,
		EquifaxCreditActivator.CONSUMER_HARD_SECURITY_CODE,
		EquifaxCreditActivator.CONSUMER_DAYS_VALID,
		EquifaxCreditActivator.CONSUMER_ENVIRONMENT_FLAG,
		EquifaxCreditActivator.BUSINESS_USER_SITE_ID,
		EquifaxCreditActivator.BUSINESS_PASSWORD,
		EquifaxCreditActivator.BUSINESS_CUSTOMER_CODE,
		EquifaxCreditActivator.BUSINESS_MEMBER_NUMBER,
		EquifaxCreditActivator.BUSINESS_SECURITY_CODE,
		EquifaxCreditActivator.BUSINESS_SERVICE_CODE,
		EquifaxCreditActivator.BUSINESS_DAYS_VALID,
		EquifaxCreditActivator.BUSINESS_ENVIRONMENT_FLAG
	};
}