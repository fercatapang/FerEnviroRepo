public with sharing class UIDataProviderAdmin extends nFORCE.ALifeCycleDataProvider{

	public override void run(Boolean isUpgrade){
		installUITemplateGeneratorRoute();
	}

	private void installUITemplateGeneratorRoute(){
		List<nFORCE__Group__c> queriedAdminGroup = [
			SELECT
				Id
			FROM
				nFORCE__Group__c
			WHERE
				nFORCE__App__c = :ADMIN_GROUP_APP
		];
		if(queriedAdminGroup.isEmpty()){
			return;
		}
		nFORCE__Group__c adminGroup = queriedAdminGroup[0];

		List<nFORCE__Route__c> queriedRoute = [
			SELECT
				Id
			FROM
				nFORCE__Route__c
			WHERE
				nFORCE__App__c = :TEMPLATE_GENERATOR_APP
		];
		if(!queriedRoute.isEmpty()){
			return;
		}

		nFORCE__Route__c route = new nFORCE__Route__c(
			Name = Label.Visualforce_Page_Generator,
			nFORCE__App__c = TEMPLATE_GENERATOR_APP,
			nFORCE__Topbar__c = getPageName(Page.nFORCE__Topbar),
			nFORCE__Body__c = getPageName(Page.UI_Template_Generator),
			nFORCE__Navigation__c = getPageName(Page.nFORCE__Navigation),
			nFORCE__Sub_Navigation__c = getPageName(Page.nFORCE__Sub_Navigation));

		nFORCE.DmlUtility.insertObj(route);

		nFORCE__Route_Group__c routeGroup = new nFORCE__Route_Group__c(
			nFORCE__Route__c = route.Id,
			nFORCE__Group__c = adminGroup.Id,
			nFORCE__Order__c = 1000);

		nFORCE.DmlUtility.insertObj(routeGroup);
	}

	private String getPageName(PageReference pg) {
		if (pg != null) {
			String pageName = String.valueOf(pg.getURL().replace(APEX, EMPTY));
			if(pageName.contains('__')){
				return pageName;
			}else{
				return PAGE_PREFIX + pageName;
			}
		}
		else {
			return null;
		}
	}

	private static final String ADMIN_GROUP_APP = 'admin',
		TEMPLATE_GENERATOR_APP = 'tool-ui-template-generator',
		EMPTY = '',
		APEX = '/apex/',
		PAGE_PREFIX = 'c__';
}