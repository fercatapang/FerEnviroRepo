global with sharing class CSA_RiskRatingDataInstaller implements InstallHandler, UninstallHandler {
	global void onInstall(InstallContext context) {
		nForce__Route__c route = this.getCreateRoute(ROUTENAME, 
												ROUTEBODY, 
												ROUTEAPP, 
												ROUTENAVIGATION, 
												ROUTESUBNAV, 
												ROUTETOPBAR);

		Database.insert(route);

		LLC_BI__System_Properties__c property = this.getCreateSystemProperty(PROPERTYCATEGORY, 
																			 PROPERTYACTIVE, 
																			 PROPERTYKEY, 
																			 PROPERTYVALUE);

		Database.insert(property);
	}

	global void onUninstall(UninstallContext context) {
		List<nForce__Route__c> routes = this.getRoutes(ROUTEBODY);
		List<nForce__Route_Group__c> routeGroups = new List<nForce__Route_Group__c>();
		if (!routes.isEmpty()) {
			routeGroups = this.getRouteGroups(routes);
			Database.delete(routeGroups);
			Database.delete(routes);
		}

		List<LLC_BI__System_Properties__c> systemProperties = this.getSystemProperties(PROPERTYCATEGORY, 
																					   PROPERTYKEY);

		if (!systemProperties.isEmpty()) {
			Database.delete(systemProperties);
		}
	}

	private nForce__Route__c getCreateRoute(String name, 
											String body,
											String app, 
											String nav, 
											String subNav, 
											String topbar) {
		nForce__Route__c newR = new nForce__Route__c(
			Name = name,
			nFORCE__Body__c = body,
			nForce__App__c = app,
			nFORCE__lookupKey__c = generateRandomString(18),
			nFORCE__Navigation__c = nav,
			nFORCE__Sub_Navigation__c = subnav,
			nFORCE__Topbar__c = topbar);

		return newR;
	}

	private LLC_BI__System_Properties__c getCreateSystemProperty(String category, 
																 Boolean active, 
																 String key, 
																 String value) {
		LLC_BI__System_Properties__c newSP = new LLC_BI__System_Properties__c(
			Name = generateRandomString(18),
			LLC_BI__Category_Name__c = category,
			LLC_BI__Is_Active__c = active,
			LLC_BI__Key__c = key,
			LLC_BI__Value__c = value);

		return newSP;
	}

	private List<nForce__Route__c> getRoutes(String body) {
		return [SELECT
					Id
				FROM
					nForce__Route__c
				WHERE 
					nForce__Body__c = :body];
	}

	private List<nFORCE__Route_Group__c> getRouteGroups(List<nForce__Route__c> routes) {
		String[] ids = new List<String>();
		for (nForce__Route__c r: routes) {
			ids.add(r.Id);
		}

		return [SELECT
					Id,
					nForce__Route__c
				FROM
					nFORCE__Route_Group__c
				WHERE 
					nForce__Route__c IN :ids];
	}

	private List<LLC_BI__System_Properties__c> getSystemProperties(String category, String key) {
		return [SELECT
					Id
				FROM
					LLC_BI__System_Properties__c
				WHERE 
					LLC_BI__Category_Name__c = :category
				AND
					LLC_BI__Key__c = :key];
	}

	public static String generateRandomString(Integer len) {
		final String chars = NUMBERSFORRANDOMIZER;
		String randStr = BLANK;
		while (randStr.length() < len) {
			Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
			randStr += chars.substring(idx, idx + 1);
		}
		return randStr; 
	}

	private static final String ROUTENAME = 'Risk Rating Selection';
	private static final String ROUTEBODY = 'c__CSA_LoanAccountRiskRating';
	private static final String ROUTEAPP = 'risk-rating-selector';
	private static final String ROUTENAVIGATION = 'nforce__navigation';
	private static final String ROUTESUBNAV = 'nforce__sub_navigation';
	private static final String ROUTETOPBAR = 'nforce__topbar';
	private static final String PROPERTYCATEGORY = 'CSA Risk Rating Selector';
	private static final Boolean PROPERTYACTIVE = true;
	private static final String PROPERTYKEY = 'Risk Rating Data Installer';
	private static final String PROPERTYVALUE = 'true';
	private static final String NUMBERSFORRANDOMIZER = '0123456789';
	private static final String BLANK = '';

}