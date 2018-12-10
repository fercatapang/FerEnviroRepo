@isTest
public class TestCSA_AccountRiskRatingController {
	public static LLC_BI__Risk_Grade_Template__c accountTemplate;
    public static LLC_BI__Risk_Grade_Template__c loanTemplate;

	@testSetup 
	static void setupTestData() {
		Account acct = new Account(Name = 'Test Acc');
        Database.insert(acct);
	}

	@isTest
	public static void start() {
		Account acctFromSetup = [SELECT Id FROM Account LIMIT 1];
		ApexPages.CurrentPage().getParameters().put('Id', acctFromSetup.Id);
		CSA_AccountRiskRatingController ARRC = new CSA_AccountRiskRatingController();

		System.assertEquals(acctFromSetup.Id, ARRC.acct.Id);
	}

	@isTest
	public static void sccountRiskRatingSaveError() {
		Account acctFromSetup = [SELECT Id FROM Account LIMIT 1];
		ApexPages.CurrentPage().getParameters().put('Id', acctFromSetup.Id);
		CSA_AccountRiskRatingController ARRC = new CSA_AccountRiskRatingController();

		Test.startTest();
		
		ARRC.accountRiskRatingSave();

		Test.stopTest();
	}

	@isTest
	public static void loanRiskRatingSaveSuccess() {
		Account acctFromSetup = [SELECT Id FROM Account LIMIT 1];
		ApexPages.CurrentPage().getParameters().put('Id', acctFromSetup.Id);
		CSA_AccountRiskRatingController ARRC = new CSA_AccountRiskRatingController();

		init();
		acctFromSetup.Risk_Rating_Template__c = 'Individual';

		Test.startTest();
		
		ARRC.acct = acctFromSetup;
		ARRC.accountRiskRatingSave();

		Test.stopTest();
	}

	@isTest
	public static void isHelpTextRiskTemplate() {
		Account acctFromSetup = [SELECT Id FROM Account LIMIT 1];
		ApexPages.CurrentPage().getParameters().put('Id', acctFromSetup.Id);
		CSA_AccountRiskRatingController ARRC = new CSA_AccountRiskRatingController();

		Test.startTest();

		ARRC.getIsHelpTextRiskTemplate();
		
		Test.stopTest();
	}

	@isTest
	public static void helpTextRiskTemplate() {
		Account acctFromSetup = [SELECT Id FROM Account LIMIT 1];
		ApexPages.CurrentPage().getParameters().put('Id', acctFromSetup.Id);
		CSA_AccountRiskRatingController ARRC = new CSA_AccountRiskRatingController();

		Test.startTest();

		ARRC.getHelpTextRiskTemplate();
		
		Test.stopTest();
	}

	public static void init() {        
        configureLoanStageStatus();
                
        LLC_BI__Risk_Grade_Template__c template = new LLC_BI__Risk_Grade_Template__c();
        template.Name = 'test1';
        template.LLC_BI__Template_Object_Type__c = 'Account';
        Database.insert(template);
        accountTemplate = [SELECT Id, Name FROM LLC_BI__Risk_Grade_Template__c WHERE Name = 'test1' LIMIT 1];
        insertRiskGradeFactorsAndCriteria(accountTemplate);
        
        template = new LLC_BI__Risk_Grade_Template__c();
        template.Name = 'test2';
        template.LLC_BI__Template_Object_Type__c = 'LLC_BI__Loan__c';
		template.LLC_BI__Template_Object_Field_Name__c = 'Risk_Rating_Template__c';
		template.LLC_BI__Template_Object_Field_Value__c = 'Individual';
        Database.insert(template);
        loanTemplate = [SELECT Id, Name FROM LLC_BI__Risk_Grade_Template__c WHERE Name = 'test2' LIMIT 1];
        insertRiskGradeFactorsAndCriteria(loanTemplate);
    }
    
    private static void insertRiskGradeFactorsAndCriteria(LLC_BI__Risk_Grade_Template__c template){
        LLC_BI__Risk_Grade_Factor__c f = new LLC_BI__Risk_Grade_Factor__c();
        f.Name = 'risk grade factor name1';
        f.LLC_BI__Risk_Grade_Template__c = template.Id;
        f.LLC_BI__Type__c = 'Quantitative';
        f.LLC_BI__Weight__c = 0.3;
        f.LLC_BI__Units__c = '$';
        Database.SaveResult lsr = Database.insert(f);
        String riskGradeFactorId = lsr.getId();
        
        LLC_BI__Risk_Grade_Criteria__c criteria = new LLC_BI__Risk_Grade_Criteria__c();
        criteria.LLC_BI__High__c = 10.0;
        criteria.LLC_BI__Low__c = 6.0;
        criteria.LLC_BI__Risk_Grade__c = '1';
        criteria.LLC_BI__Risk_Grade_Factor__c = riskGradeFactorId;
        lsr = Database.insert(criteria);
        
        criteria = new LLC_BI__Risk_Grade_Criteria__c();
        criteria.LLC_BI__High__c = 5.0;
        criteria.LLC_BI__Low__c = 1.0;
        criteria.LLC_BI__Risk_Grade__c = '2';
        criteria.LLC_BI__Risk_Grade_Factor__c = riskGradeFactorId;
        lsr = Database.insert(criteria);
        
        f = new LLC_BI__Risk_Grade_Factor__c();
        f.Name = 'risk grade factor name2';
        f.LLC_BI__Risk_Grade_Template__c = template.Id;
        f.LLC_BI__Type__c = 'Qualitative';
        f.LLC_BI__Weight__c = 0.7;
        f.LLC_BI__Units__c = '';
        lsr = Database.insert(f);
        riskGradeFactorId = lsr.getId();
        
        criteria = new LLC_BI__Risk_Grade_Criteria__c();
        criteria.LLC_BI__Description__c = 'not bad';
        criteria.LLC_BI__Risk_Grade__c = '1';
        criteria.LLC_BI__Risk_Grade_Factor__c = riskGradeFactorId;
        lsr = Database.insert(criteria);
        
        criteria = new LLC_BI__Risk_Grade_Criteria__c();
        criteria.LLC_BI__Description__c = 'also not bad';
        criteria.LLC_BI__Risk_Grade__c = '2';
        criteria.LLC_BI__Risk_Grade_Factor__c = riskGradeFactorId;
        lsr = Database.insert(criteria);
    }

    private static void productReset(){
        List<LLC_BI__Product_Line__c> pline = 
            [select id from LLC_BI__Product_Line__c where Name != null];
        if (pline != null && pline.size() > 0) {
            delete pline;
        }
        List<LLC_BI__Product_Type__c> ptype = [select id from LLC_BI__Product_Type__c where Name != null];
        if (ptype != null && ptype.size() > 0) {
            delete ptype;
        }
        List<LLC_BI__Product__c> prod = [select id from LLC_BI__Product__c where Name != null];
        if (prod != null && prod.size() > 0) {
            delete ptype;
        }       
    }
    public static void configurationReset(String configurationKey) {
        LLC_BI__CFG_ConfigKey__c confKey = null;
        try {
        confKey = 
        [
            select
                Id
            from
                LLC_BI__CFG_ConfigKey__c
            where
                LLC_BI__CFG_ConfigKey__c.name = :configurationKey
        ];
        
        if (confKey != null) {
            List<LLC_BI__CFG_CKJ__c> joinValues =
                [select
                    LLC_BI__CFG_ConfigValue__c
                from
                    LLC_BI__CFG_CKJ__c
                where
                    LLC_BI__CFG_ConfigKeys__c =:confKey.id
                ];
                
            for (LLC_BI__CFG_CKJ__c value: joinValues) {
                List<LLC_BI__CFG_ConfigValue__c> configValues = 
                [select
                    LLC_BI__Key__c,
                    LLC_BI__Value__c,
                    LLC_BI__fieldValue__c,
                    LLC_BI__Category__c
                from
                    LLC_BI__CFG_ConfigValue__c
                where
                    id =: value.LLC_BI__CFG_ConfigValue__c
                 ];
                 delete configValues;
            }
            delete confKey;
        }
        } catch (Exception e) {
            // they don't exist, do nothing
        }
    }

    public static void configureLoanStageStatus(Boolean createSecondProduct) {

        configurationReset('KY_GBL_NamespacePrefixBI');
        
        LLC_BI__CFG_ConfigKey__c cm_key_prefix = new LLC_BI__CFG_ConfigKey__c();
        cm_key_prefix.Name = 'KY_GBL_NamespacePrefixBI';
        insert cm_key_prefix;
        
        LLC_BI__CFG_ConfigValue__c ccfv_prefix = new LLC_BI__CFG_ConfigValue__c();
        ccfv_prefix.LLC_BI__Key__c = 'Bankr_BI_Prefix';
        ccfv_prefix.LLC_BI__FieldValue__c = '';
        ccfv_prefix.LLC_BI__Category__c = 'General';
        insert ccfv_prefix;
        
        LLC_BI__CFG_CKJ__c ckj5 = new LLC_BI__CFG_CKJ__c();
        ckj5.LLC_BI__CFG_ConfigKeys__c = cm_key_prefix.Id;
        ckj5.LLC_BI__CFG_ConfigValue__c = ccfv_prefix.Id;
        insert ckj5;
 
        productReset();
            LLC_BI__Product_Line__c pl = new LLC_BI__Product_Line__c();
            pl.Name = 'Test Product Line 1';
            pl.LLC_BI__Product_Object__c = LLC_BI__Loan__c.getSObjectType().getDescribe().getLocalName();
            insert pl;
            
            LLC_BI__Product_Type__c pt = new LLC_BI__Product_Type__c();
            pt.Name = 'Test Product Type 1';
            pt.LLC_BI__Usage_Type__c = 'Loan';
            pt.LLC_BI__Product_Line__c = pl.Id;
            pt.LLC_BI__lookupKey__c = 'PT01';
            insert pt;
            
            LLC_BI__Product_Type__c pt2 = new LLC_BI__Product_Type__c();
            pt2.Name = 'Test Product Type 2';
            pt2.LLC_BI__Usage_Type__c = 'Loan';
            pt2.LLC_BI__Product_Line__c = pl.Id;
            pt2.LLC_BI__lookupKey__c = 'PT02';
            insert pt2;
            
            LLC_BI__Product__c p = new LLC_BI__Product__c();
            p.Name = 'Test Product 1';
            p.LLC_BI__Product_Type__c = pt.Id;
            insert p;

            if (createSecondProduct) {
                LLC_BI__Product__c p2 = new LLC_BI__Product__c();
                p2.Name = 'Test Product 2';
                p2.LLC_BI__Product_Type__c = pt.Id;
                insert p2;
            }

            configurationReset('PT01');         
            configurationReset('PT02');         
            
            //Configure Loan Stages
            LLC_BI__CFG_ConfigKey__c cfk = new LLC_BI__CFG_ConfigKey__c();
            cfk.Name = [select LLC_BI__lookupKey__c from LLC_BI__Product_Type__c where Id=: pt.Id].LLC_BI__lookupKey__c;
            insert cfk;
            
            LLC_BI__CFG_ConfigKey__c cfk2 = new LLC_BI__CFG_ConfigKey__c();
            cfk2.Name = [select LLC_BI__lookupKey__c from LLC_BI__Product_Type__c where Id=: pt2.Id].LLC_BI__lookupKey__c;
            insert cfk2;
            
            LLC_BI__CFG_ConfigValue__c ccfv1 = new LLC_BI__CFG_ConfigValue__c();
            ccfv1.LLC_BI__Key__c = 'Complete';
            ccfv1.LLC_BI__Value__c = 'Complete';
            ccfv1.LLC_BI__fieldValue__c = 'Complete';
            ccfv1.LLC_BI__Category__c = 'Loan Stage';
            insert ccfv1;
            
            LLC_BI__CFG_CKJ__c ckj1 = new LLC_BI__CFG_CKJ__c();
            ckj1.LLC_BI__CFG_ConfigKeys__c = cfk.Id;
            ckj1.LLC_BI__CFG_ConfigValue__c = ccfv1.Id;
            insert ckj1;
            
            LLC_BI__CFG_ConfigValue__c ccfv2 = new LLC_BI__CFG_ConfigValue__c();
            ccfv2.LLC_BI__Key__c = 'Closed';
            ccfv2.LLC_BI__Value__c = 'Closed Funded';
            ccfv2.LLC_BI__fieldValue__c = 'Closed Funded';
            ccfv2.LLC_BI__Category__c = 'Loan Stage';
            insert ccfv2;
            
            LLC_BI__CFG_CKJ__c ckj2 = new LLC_BI__CFG_CKJ__c();
            ckj2.LLC_BI__CFG_ConfigKeys__c = cfk.Id;
            ckj2.LLC_BI__CFG_ConfigValue__c = ccfv2.Id;
            insert ckj2;
            
            LLC_BI__CFG_ConfigValue__c cvpt2 = new LLC_BI__CFG_ConfigValue__c();
            cvpt2.LLC_BI__Key__c = 'Closed';
            cvpt2.LLC_BI__Value__c = 'Closed Funded';
            cvpt2.LLC_BI__fieldValue__c = 'Closed Funded';
            cvpt2.LLC_BI__Category__c = 'Loan Stage';
            insert cvpt2;
            
            LLC_BI__CFG_CKJ__c ckj3 = new LLC_BI__CFG_CKJ__c();
            ckj3.LLC_BI__CFG_ConfigKeys__c = cfk2.Id;
            ckj3.LLC_BI__CFG_ConfigValue__c = cvpt2.Id;
            insert ckj3;
            
            //Configure Loan Status's
            LLC_BI__CFG_ConfigValue__c ccfv3 = new LLC_BI__CFG_ConfigValue__c();
            ccfv3.LLC_BI__Key__c = 'Declined';
            ccfv3.LLC_BI__Value__c = 'Declined';
            ccfv3.LLC_BI__fieldValue__c = 'Declined';
            ccfv3.LLC_BI__Category__c = 'Loan Status';
            insert ccfv3;
            
            LLC_BI__CFG_CKJ__c ckj4 = new LLC_BI__CFG_CKJ__c();
            ckj4.LLC_BI__CFG_ConfigKeys__c = cfk.Id;
            ckj4.LLC_BI__CFG_ConfigValue__c = ccfv3.Id;
            insert ckj4;
            
            //Add our Doc Manager records so we can really test our CM move code
            LLC_BI__DocManager__c dm = new LLC_BI__DocManager__c();
            dm.Name = 'TestLoanDM';
            dm.LLC_BI__lookupKey__c = 'TestDocMan';
            insert dm;
            
            LLC_BI__DocTab__c dt = new LLC_BI__DocTab__c();
            dt.Name = 'Credit File Test';
            dt.LLC_BI__DocManager__c = dm.Id;
            dt.LLC_BI__lookupKey__c = 'TestDocTab';
            insert dt;
            
            LLC_BI__DocType__c dtype = new LLC_BI__DocType__c();
            dtype.Name = 'Underwriting Test';
            dtype.LLC_BI__DocManager__c = dm.Id;
            dtype.LLC_BI__DocTab__c = dt.Id;
            dtype.LLC_BI__lookupKey__c = 'TestDocType';
            insert dtype;
            
            //Configure the remainder of our Change Memo information now that we have docman Ids
            LLC_BI__CFG_ConfigValue__c cvdt = new LLC_BI__CFG_ConfigValue__c();
            cvdt.LLC_BI__Key__c = 'CM_DocTabLookupKey';
            cvdt.LLC_BI__Value__c = 'TestDocTab';
            cvdt.LLC_BI__fieldValue__c = 'TestDocTab';
            cvdt.LLC_BI__Category__c = 'Change Memo';
            insert cvdt;
                
            LLC_BI__CFG_CKJ__c cm_join1 = new LLC_BI__CFG_CKJ__c();
            cm_join1.LLC_BI__CFG_ConfigKeys__c = cfk.Id;
            cm_join1.LLC_BI__CFG_ConfigValue__c = cvdt.Id;
            insert cm_join1;
    
            LLC_BI__CFG_ConfigValue__c cvdty = new LLC_BI__CFG_ConfigValue__c();
            cvdty.LLC_BI__Key__c = 'CM_DocTypeLookupKey';
            cvdty.LLC_BI__Value__c = 'TestDocType';
            cvdty.LLC_BI__fieldValue__c = 'TestDocType';
            cvdty.LLC_BI__Category__c = 'Change Memo';
            insert cvdty;
            
            LLC_BI__CFG_CKJ__c cm_join2 = new LLC_BI__CFG_CKJ__c();
            cm_join2.LLC_BI__CFG_ConfigKeys__c = cfk.Id;
            cm_join2.LLC_BI__CFG_ConfigValue__c = cvdty.Id;
            insert cm_join2;
            
            LLC_BI__CFG_ConfigValue__c cvdm = new LLC_BI__CFG_ConfigValue__c();
            cvdm.LLC_BI__Key__c = 'CM_DocManLookupKey';
            cvdm.LLC_BI__Value__c = 'TestDocMan';
            cvdm.LLC_BI__fieldValue__c = 'TestDocMan';
            cvdm.LLC_BI__Category__c = 'Change Memo';
            insert cvdm;
            
            LLC_BI__CFG_CKJ__c cm_join3 = new LLC_BI__CFG_CKJ__c();
            cm_join3.LLC_BI__CFG_ConfigKeys__c = cfk.Id;
            cm_join3.LLC_BI__CFG_ConfigValue__c = cvdm.Id;
            insert cm_join3;

    }

    /*******************************
    * Setup our ConfigValue Configurations
    ********************************/
    public static void configureLoanStageStatus() {

        configureLoanStageStatus(false);

    }
    /******************/
    
    public static void createTestRole(String RoleName) {
        User u = [select Id from User where Id = :UserInfo.getUserId() ];
        system.runAs(u) {
            //Check if the role exists first. If it doesn't, create it
            ID ProfileId = [select id from Profile where Name='Standard User'].Id;
            ID RoleId;
            try {
                RoleId = [select Id from UserRole where Name=: RoleName].Id;    
            } catch(QueryException e) {
                UserRole ur = new UserRole();
                ur.Name = RoleName;
                insert ur;
                RoleId = ur.Id;
            }
        }
    }
}