public class CSA_AccountRiskRatingController {
	public Account acct {get;Set;}
	public String errorMessage {get;set;}

	public CSA_AccountRiskRatingController() {
		this.acct = this.getAcct(ApexPages.currentPage().getParameters().get(PARAMETER_NAME));
	}

	public PageReference accountRiskRatingSave() {
		if (String.ISNOTBLANK(acct.Risk_Rating_Template__c)) {
			try {	        
				Database.update(this.acct);

				LLC_BI__Annual_Review__c newAR = new LLC_BI__Annual_Review__c(
					LLC_BI__Account__c = this.acct.Id);

				try {	        
					Database.insert(newAR);

					PageReference pageRef = getRiskRatingPageURL(this.acct.Id, newAR.Id);
					return pageRef;
				} catch(Exception ex) {
					this.errorMessage = ex.getMessage();
				}
			} catch(Exception ex) {
				this.errorMessage = ex.getMessage();
			}
		} else {
			if (String.ISBLANK(this.acct.Risk_Rating_Template__c)) {
				this.errorMessage = System.Label.Risk_Rating_Selector_Template_Error_Msg;
			}
		}
		return null;
	}

	public PageReference getRiskRatingPageURL(Id recordId, Id arId) {
		try{
			PageReference pageRef;
			nFORCE.RouteController rc = new nFORCE.RouteController();
			nFORCE__Route__c route = rc.getDashboardRoute();

			String app = route != null ? route.nFORCE__App__c : null;
			if(String.isNotBlank(app)){
				pageRef = new PageReference(System.Label.Risk_Rating_Selector_Save_URL_UI + recordId);
			} else {
				pageRef = new PageReference(SLASH + arId);
			}
			pageRef.setRedirect(true);
			return pageRef;
		} catch (Exception ex){
			this.errorMessage = ex.getMessage();
		}
		return null;
	}

	private Account getAcct(Id recordId) {
		return [
			SELECT
				Id,
				Name,
				Risk_Rating_Template__c
			FROM
				Account
			WHERE
				Id = :recordId LIMIT 1];
	}

	public Boolean getIsHelpTextRiskTemplate() {
		return String.isNotBlank(this.getFieldResult(Account.Risk_Rating_Template__c.getDescribe()).getInlineHelpText());
	}

	public String getHelpTextRiskTemplate() {
		return this.getFieldResult(Account.Risk_Rating_Template__c.getDescribe()).getInlineHelpText();
	}

	private Schema.DescribeFieldResult getFieldResult(Schema.DescribeFieldResult result) {
		return result;
	}

	private static final String PARAMETER_NAME = 'id';
	private static final String BLANK = '';
	private static final String NONE_SELECT_OPTION = '-- None --';
	private static final String SLASH = '/';
}