@isTest
private class TestEquifaxCreditAppFacade {

	@isTest
	private static void testStoreDocuments_hasImplementation() {
		EquifaxCreditAppFacade facade = new EquifaxCreditAppFacade();
		MockDocManAttachmentHandler attachmentHandler = new MockDocManAttachmentHandler();
		facade.attachmentHandler = attachmentHandler;
		Account acct = new Account(Name = 'Test');
		insert acct;
		nFUSE__Transaction_Log__c tLog = new nFUSE__Transaction_Log__c(
			nFUSE__Action__c = 'test',
			nFUSE__Api_Version__c = '1.0',
			nFUSE__Requesting_User_Id__c = UserInfo.getUserId(),
			nFUSE__Requested_By_User_Id__c = UserInfo.getUserId(),
			nFUSE__Transaction_Status__c = 'INPROGRESS',
			nFUSE__Object_Id__c = acct.Id,
			nFUSE__Primary_Object_Id__c = acct.Id,
			nFUSE__App_Plugin__c = 'Equifax_Credit',
			nFUSE__External_Id__c = new nFORCE.GuidGenerator().randomUUID()
		);
		insert tLog;
		Test.startTest();
		facade.storeDocument(tLog.nFUSE__External_Id__c, 'test', 'some doc content');
		Test.stopTest();
		System.assertEquals(Blob.valueOf('some doc content'), attachmentHandler.storeDocumentBlob);
	}

	@isTest
	private static void testPreCommAdjustments_Business(){
		initEquifaxBusinessProperties();
		MiddlewareMessageMock message = new MiddlewareMessageMock()
			.putProperty(EquifaxCreditAppFacade.REPORT_TYPE, EquifaxCreditAppFacade.REPORT_TYPE_BUSINESS);
		EquifaxCreditAppFacade facade = new EquifaxCreditAppFacade();

		facade.preCommAdjustments(message);

		System.assertEquals('BUSINESS_USER_SITE_ID', message.properties.get(EquifaxCreditActivator.BUSINESS_USER_SITE_ID));
		System.assertEquals('BUSINESS_PASSWORD', message.properties.get(EquifaxCreditActivator.BUSINESS_PASSWORD));
		System.assertEquals( new List<String>{'BUSINESS_CUSTOMER_NUMBER1','BUSINESS_CUSTOMER_NUMBER2'}, message.properties.get(EquifaxCreditActivator.BUSINESS_MEMBER_NUMBER));
		System.assertEquals('BUSINESS_SECURITY_CODE', message.properties.get(EquifaxCreditActivator.BUSINESS_SECURITY_CODE));
		System.assertEquals('BUSINESS_SERVICE_CODE', message.properties.get(EquifaxCreditActivator.BUSINESS_SERVICE_CODE));
		System.assertEquals('BUSINESS_CUSTOMER_CODE', message.properties.get(EquifaxCreditActivator.BUSINESS_CUSTOMER_CODE));
		System.assertEquals('BUSINESS_ENVIRONMENT_FLAG', message.properties.get(EquifaxCreditActivator.BUSINESS_ENVIRONMENT_FLAG));
	}

	@isTest
	private static void testPreCommAdjustments_Consumer(){
		initEquifaxConsumerProperties();
		MiddlewareMessageMock message = new MiddlewareMessageMock()
			.putProperty(EquifaxCreditAppFacade.REPORT_TYPE, EquifaxCreditAppFacade.REPORT_TYPE_HARD);
		EquifaxCreditAppFacade facade = new EquifaxCreditAppFacade();

		facade.preCommAdjustments(message);

		System.assertEquals('CONSUMER_USER_SITE_ID', message.properties.get(EquifaxCreditActivator.CONSUMER_USER_SITE_ID));
		System.assertEquals('CONSUMER_PASSWORD', message.properties.get(EquifaxCreditActivator.CONSUMER_PASSWORD));
		System.assertEquals('CONSUMER_CUSTOMER_CODE', message.properties.get(EquifaxCreditActivator.CONSUMER_CUSTOMER_CODE));

		System.assertEquals(new List<String>{'CONSUMER_CUSTOMER_NUMBER1','CONSUMER_CUSTOMER_NUMBER2'}, message.properties.get(EquifaxCreditActivator.CONSUMER_HARD_MEMBER_NUMBER));
		System.assertEquals('CONSUMER_HARD_SECURITY_CODE', message.properties.get(EquifaxCreditActivator.CONSUMER_HARD_SECURITY_CODE));
		System.assertEquals('CONSUMER_ENVIRONMENT_FLAG', message.properties.get(EquifaxCreditActivator.CONSUMER_ENVIRONMENT_FLAG));


	}

	@isTest
	private static void testPreCommAdjustments_MissingExpectedProperty(){
		MiddlewareMessageMock message = new MiddlewareMessageMock()
			.putProperty(EquifaxCreditAppFacade.REPORT_TYPE, EquifaxCreditAppFacade.REPORT_TYPE_BUSINESS);
		EquifaxCreditAppFacade facade = new EquifaxCreditAppFacade();

		try{
			facade.preCommAdjustments(message);
			System.assert(false, 'Expected Exception NOT thrown');
		}
		catch(EquifaxCreditAppFacade.XEquifaxAppFacadeException ex){
			System.assert(ex.getMessage().startsWith(EquifaxCreditAppFacade.X_MISSING_REQUIRED_PROPERTY));
		}
	}

	@isTest
	private static void testPreCommAdjustments_MissingOrUnknownReportType(){
		EquifaxCreditAppFacade facade = new EquifaxCreditAppFacade();
		try{
			facade.preCommAdjustments(new MiddlewareMessageMock());
			System.assert(false, 'Expected Exception NOT thrown');
		}
		catch(EquifaxCreditAppFacade.XEquifaxAppFacadeException ex){
			System.assertEquals(EquifaxCreditAppFacade.X_MISSING_UNKNOWN_REPORT_TYPE, ex.getMessage());
		}

		try{
			facade.preCommAdjustments(new MiddlewareMessageMock()
				.putProperty(EquifaxCreditAppFacade.REPORT_TYPE, 'Something Strange')
			);
			System.assert(false, 'Expected Exception NOT thrown');
		}
		catch(EquifaxCreditAppFacade.XEquifaxAppFacadeException ex){
			System.assertEquals(EquifaxCreditAppFacade.X_MISSING_UNKNOWN_REPORT_TYPE, ex.getMessage());
		}
	}

	private static void initEquifaxConsumerProperties(){
		NFORCE__System_Properties__c[] props = new NFORCE__System_Properties__c[]{
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_USER_SITE_ID, 'CONSUMER_USER_SITE_ID'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_PASSWORD, 'CONSUMER_PASSWORD'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_CUSTOMER_CODE, 'CONSUMER_CUSTOMER_CODE'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_SOFT_MEMBER_NUMBER, 'CONSUMER_CUSTOMER_NUMBER1, CONSUMER_CUSTOMER_NUMBER2'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_SOFT_SECURITY_CODE, 'CONSUMER_SOFT_SECURITY_CODE'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_HARD_MEMBER_NUMBER, 'CONSUMER_CUSTOMER_NUMBER1, CONSUMER_CUSTOMER_NUMBER2'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_HARD_SECURITY_CODE, 'CONSUMER_HARD_SECURITY_CODE'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_DAYS_VALID, 'CONSUMER_DAYS_VALID'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.CONSUMER_ENVIRONMENT_FLAG, 'CONSUMER_ENVIRONMENT_FLAG')
		};
		insert(props);
	}

	private static void initEquifaxBusinessProperties(){
		NFORCE__System_Properties__c[] props = new NFORCE__System_Properties__c[]{
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_USER_SITE_ID, 'BUSINESS_USER_SITE_ID'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_PASSWORD, 'BUSINESS_PASSWORD'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_CUSTOMER_CODE, 'BUSINESS_CUSTOMER_CODE'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_MEMBER_NUMBER, 'BUSINESS_CUSTOMER_NUMBER1, BUSINESS_CUSTOMER_NUMBER2'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_SECURITY_CODE, 'BUSINESS_SECURITY_CODE'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_SERVICE_CODE, 'BUSINESS_SERVICE_CODE'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_DAYS_VALID, 'BUSINESS_DAYS_VALID'),
			create(EQUIFAX_CATEGORY, EquifaxCreditActivator.BUSINESS_ENVIRONMENT_FLAG, 'BUSINESS_ENVIRONMENT_FLAG')
		};
		insert(props);
	}

	private class MiddlewareMessageMock extends nFUSE.AMiddlewareMessage {
		public MiddlewareMessageMock(){}

		public MiddlewareMessageMock putProperty(String key, String value){
			this.properties.put(key, value);
			return this;
		}
	}

	private static NFORCE__System_Properties__c create(String cat, String key, String val){
		return new NFORCE__System_Properties__c(
			Name = new nFORCE.GuidGenerator().randomUUID(),
			NFORCE__Category_Name__c = cat,
			NFORCE__Key__c = key,
			NFORCE__Value__c = val,
			NFORCE__Is_Active__c = true
		);
	}


	private static final String EQUIFAX_CATEGORY = EquifaxCreditAppFacade.PLUGIN_NAME + 'Configuration';

	private class MockDocManAttachmentHandler extends EquifaxCreditAppFacade.DocManAttachmentHandler {

		public Blob storeDocumentBlob {get; private set; }

		public override void storeDocument(String transactionId, String templateName, Blob docContent) {
			storeDocumentBlob = docContent;
		}

		public override void storeDocument(String transactionId, String templateName, String templateFileName, Blob docContent) {
			storeDocumentBlob = docContent;
		}
	}
}