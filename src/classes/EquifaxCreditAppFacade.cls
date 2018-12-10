/**
 * Credit AppFacade Extension for Equifax
 */
global with sharing class EquifaxCreditAppFacade extends nFUSE.CreditAppFacade {

	@TestVisible private DocManAttachmentHandler attachmentHandler = new DocManAttachmentHandler();

	private Map<String, String> configurationMap;

	/**
	 * Stores Documents returned from the Middleware
	 * @param The external transaction identifier
	 * @param The document name (not used with this plugin)
	 * @param The document content
	 */
	global override void storeDocument(String transactionId, String docName, String docContent) {
		Blob content = Blob.valueOf(docContent);
		attachmentHandler.storeDocument(transactionId, REPORT_NAME, content);
	}

	/**
	 * Alters the outbound middleware message
	 * @param outbound AMiddlewareMessage
	 */
	global override nFUSE.AMiddlewareMessage preCommAdjustments(nFUSE.AMiddlewareMessage message){
		if(isBusinessCreditMessage(message)){
			mergeBusinessPropertiesToMessage(message);
		}
		else if(isConsumerCreditMessage(message)){
			mergeConsumerPropertiesToMessage(message);
		}
		else throw new XEquifaxAppFacadeException(X_MISSING_UNKNOWN_REPORT_TYPE);

		return message;
	}

	private Boolean isBusinessCreditMessage(nFUSE.AMiddlewareMessage message){
		return message.properties.get(REPORT_TYPE) == REPORT_TYPE_BUSINESS;
	}

	private Boolean isConsumerCreditMessage(nFUSE.AMiddlewareMessage message){
		String reportType = (String)message.properties.get(REPORT_TYPE);

		return reportType == REPORT_TYPE_HARD || reportType == REPORT_TYPE_SOFT;
	}

	private void mergeConsumerPropertiesToMessage(nFUSE.AMiddlewareMessage message){
		String reportType = (String)message.properties.get(REPORT_TYPE);

		message.properties.put(EquifaxCreditActivator.CONSUMER_USER_SITE_ID,
			this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_USER_SITE_ID));
		message.properties.put(EquifaxCreditActivator.CONSUMER_PASSWORD,
			this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_PASSWORD));
		message.properties.put(EquifaxCreditActivator.CONSUMER_CUSTOMER_CODE,
			this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_CUSTOMER_CODE));
		message.properties.put(EquifaxCreditActivator.CONSUMER_ENVIRONMENT_FLAG,
			this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_ENVIRONMENT_FLAG));

		if(reportType == REPORT_TYPE_SOFT){
			message.properties.put(EquifaxCreditActivator.CONSUMER_SOFT_MEMBER_NUMBER,
				this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_SOFT_MEMBER_NUMBER)
					.deleteWhitespace()
					.split(CUSTOMER_NUMBER_DELIMITER));
			message.properties.put(EquifaxCreditActivator.CONSUMER_SOFT_SECURITY_CODE,
				this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_SOFT_SECURITY_CODE));
		}
		if(reportType == REPORT_TYPE_HARD){
			message.properties.put(EquifaxCreditActivator.CONSUMER_HARD_SECURITY_CODE,
				this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_HARD_SECURITY_CODE));
			message.properties.put(EquifaxCreditActivator.CONSUMER_HARD_MEMBER_NUMBER,
				this.getEquifaxProperty(EquifaxCreditActivator.CONSUMER_HARD_MEMBER_NUMBER)
					.deleteWhitespace()
					.split(CUSTOMER_NUMBER_DELIMITER));
		}
	}

	private void mergeBusinessPropertiesToMessage(nFUSE.AMiddlewareMessage message){
		message.properties.put(EquifaxCreditActivator.BUSINESS_USER_SITE_ID,
			this.getEquifaxProperty(EquifaxCreditActivator.BUSINESS_USER_SITE_ID));
		message.properties.put(EquifaxCreditActivator.BUSINESS_PASSWORD,
			this.getEquifaxProperty(EquifaxCreditActivator.BUSINESS_PASSWORD));
		message.properties.put(EquifaxCreditActivator.BUSINESS_CUSTOMER_CODE,
			this.getEquifaxProperty(EquifaxCreditActivator.BUSINESS_CUSTOMER_CODE));
		message.properties.put(EquifaxCreditActivator.BUSINESS_MEMBER_NUMBER,
			this.getEquifaxProperty(EquifaxCreditActivator.BUSINESS_MEMBER_NUMBER)
				.deleteWhitespace()
				.split(CUSTOMER_NUMBER_DELIMITER));
		message.properties.put(EquifaxCreditActivator.BUSINESS_SECURITY_CODE,
			this.getEquifaxProperty(EquifaxCreditActivator.BUSINESS_SECURITY_CODE));
		message.properties.put(EquifaxCreditActivator.BUSINESS_SERVICE_CODE,
			this.getEquifaxProperty(EquifaxCreditActivator.BUSINESS_SERVICE_CODE));
		message.properties.put(EquifaxCreditActivator.BUSINESS_ENVIRONMENT_FLAG,
			this.getEquifaxProperty(EquifaxCreditActivator.BUSINESS_ENVIRONMENT_FLAG));
	}

	private String getEquifaxProperty(String propertyKey) {
		if(configurationMap == null) retrieveKeyValueMap();
		if(!configurationMap.containsKey(propertyKey)) {
			throw new XEquifaxAppFacadeException(
				X_MISSING_REQUIRED_PROPERTY + ': ' + propertyKey
			);
		}

		return configurationMap.get(propertyKey);
	}

	private void retrieveKeyValueMap(){
		nFUSE.PluginConfigurationManager configManager = new nFUSE.PluginConfigurationManager(PLUGIN_NAME, PLUGIN_VERSION);

		configurationMap = new Map<String, String>();
		List<nFUSE.PluginConfigurationManager.PluginConfiguration> configs = configManager.getConfigurations();
		for(nFUSE.PluginConfigurationManager.PluginConfiguration config : configs) {
			configurationMap.put(config.key, config.value);
		}
	}

	@TestVisible private class XEquifaxAppFacadeException extends Exception {}

	@TestVisible
	private virtual class DocManAttachmentHandler {

		public virtual void storeDocument(String transactionId, String templateName, Blob docContent) {
			nFUSE.DocManAttachment att = new nFUSE.DocManAttachment(transactionId, templateName);
			att.storeDocument(docContent);
		}

		public virtual void storeDocument(String transactionId, String templateName, String templateFileName, Blob docContent) {
			nFUSE.DocManAttachment att = new nFUSE.DocManAttachment(transactionId, templateName, templateFileName);
			att.storeDocument(docContent);
		}
	}

	public static final String PLUGIN_NAME = 'Equifax_Credit';
	public static final String PLUGIN_VERSION = '1.0';
	@TestVisible private static String REPORT_NAME = 'Equifax_Credit';
	@TestVisible private static String REPORT_TYPE = 'ReportType';
	@TestVisible private static String REPORT_TYPE_HARD = 'Hard';
	@TestVisible private static String REPORT_TYPE_SOFT = 'Soft';
	@TestVisible private static String REPORT_TYPE_BUSINESS = 'Business';
	@TestVisible private static String CUSTOMER_NUMBER_DELIMITER = ',';
	@TestVisible private static String X_MISSING_REQUIRED_PROPERTY = 'Missing Equifax configured property';
	@TestVisible private static String X_MISSING_UNKNOWN_REPORT_TYPE = 'Unknown Report Type';
}