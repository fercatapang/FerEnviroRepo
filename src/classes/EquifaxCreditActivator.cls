/**
 * @author nCino
 * Implements the IPlugin Activator Interface and creates SystemProperties,
 * SystemConfiguration, and registers a bean for the CreditAppFacade on Activate.
 * Then does nothing on deactivate.
 **/
global with sharing class EquifaxCreditActivator implements nFUSE.IPluginActivator {
	public void onActivate() {
		nFORCE.BeanRegistry.getInstance().registerBean(
			EquifaxCreditAppFacade.class.getName(),
			nFUSE.CreditAppFacade.class,
			EquifaxCreditAppFacade.class,
			new Map<String, Object>{},
			true);

		nFUSE.ACreditPassReviewDecision.register(CreditPassReviewDecision.class);
		nFUSE.ACreditReportTypeDecision.register(CreditReportTypeDecision.class);

		addPluginConfigs();
	}

	public void onDeactivate() {}

	private void addPluginConfigs() {
		List<nFUSE.PluginConfigurationManager.PluginConfiguration> configs = new List<nFUSE.PluginConfigurationManager.PluginConfiguration> {};

		configs.add(createConfig(CONSUMER_USER_SITE_ID, null, false));
		configs.add(createConfig(CONSUMER_PASSWORD, null, true));
		configs.add(createConfig(CONSUMER_CUSTOMER_CODE, null, false));
		configs.add(createConfig(CONSUMER_SOFT_MEMBER_NUMBER, null, false));
		configs.add(createConfig(CONSUMER_SOFT_SECURITY_CODE, null, true));
		configs.add(createConfig(CONSUMER_HARD_MEMBER_NUMBER, null, false));
		configs.add(createConfig(CONSUMER_HARD_SECURITY_CODE, null, true));
		configs.add(createConfig(CONSUMER_DAYS_VALID, null, false));
		configs.add(createConfig(CONSUMER_ENVIRONMENT_FLAG, null, false));
		configs.add(createConfig(BUSINESS_USER_SITE_ID, null, false));
		configs.add(createConfig(BUSINESS_PASSWORD, null, true));
		configs.add(createConfig(BUSINESS_CUSTOMER_CODE, null, false));
		configs.add(createConfig(BUSINESS_MEMBER_NUMBER, null, false));
		configs.add(createConfig(BUSINESS_SECURITY_CODE, null, true));
		configs.add(createConfig(BUSINESS_SERVICE_CODE, null, false));
		configs.add(createConfig(BUSINESS_DAYS_VALID, null, false));
		configs.add(createConfig(BUSINESS_ENVIRONMENT_FLAG, null, false));


		new nFUSE.PluginConfigurationManager(EquifaxCreditAppFacade.PLUGIN_NAME, EquifaxCreditAppFacade.PLUGIN_VERSION).softInsertConfigurations(configs);
	}

	private nFUSE.PluginConfigurationManager.PluginConfiguration createConfig(String key, String value, Boolean isEncrypted){
		nFUSE.PluginConfigurationManager.PluginConfiguration config = new nFUSE.PluginConfigurationManager.PluginConfiguration();
		config.pluginName = EquifaxCreditAppFacade.PLUGIN_NAME;
		config.pluginVersion =EquifaxCreditAppFacade.PLUGIN_VERSION;
		config.category = EquifaxCreditAppFacade.PLUGIN_NAME;
		config.key = key;
		config.valueDataType = value;
		config.isEncrypted = isEncrypted;

		return config;
	}

	public static final String PLUGIN_CONFIG_NAME ='Equifax_CreditConfiguration';
	public static final String PLUGIN_HELP_TEXT = 'Equifax Plugin Category for Property Configuration';

	public static final String CONSUMER_USER_SITE_ID = 'Consumer User ID/Site ID';
	public static final String CONSUMER_PASSWORD = 'Consumer Password';
	public static final String CONSUMER_CUSTOMER_CODE = 'Consumer Customer Code';
	public static final String CONSUMER_SOFT_MEMBER_NUMBER = 'Consumer Soft Member Number';
	public static final String CONSUMER_SOFT_SECURITY_CODE = 'Consumer Soft Security Code';
	public static final String CONSUMER_HARD_MEMBER_NUMBER = 'Consumer Hard Member Number';
	public static final String CONSUMER_HARD_SECURITY_CODE = 'Consumer Hard Security Code';
	public static final String CONSUMER_DAYS_VALID = 'Consumer Days Valid';
	public static final String CONSUMER_ENVIRONMENT_FLAG = 'Consumer Environment Flag';
	public static final String BUSINESS_USER_SITE_ID = 'Business User ID/Site ID';
	public static final String BUSINESS_PASSWORD = 'Business Password';
	public static final String BUSINESS_CUSTOMER_CODE = 'Business Customer Code';
	public static final String BUSINESS_MEMBER_NUMBER = 'Business Member Number';
	public static final String BUSINESS_SECURITY_CODE = 'Business Security Code';
	public static final String BUSINESS_SERVICE_CODE = 'Business Service Code';
	public static final String BUSINESS_DAYS_VALID = 'Business Days Valid';
	public static final String BUSINESS_ENVIRONMENT_FLAG = 'Business Environment Flag';
}