public class BuildBaseConfiguration
{
    public void executeConfig()
    {
        LLC_BI__CFG_ConfigValue__c cfgv01 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Bankr_BI_Prefix', LLC_BI__fieldValue__c = 'LLC_BI__', LLC_BI__Category__c = 'General', LLC_BI__lookupKey__c = 'Bankr_BI_Prefix');
        insert cfgv01;
        
        LLC_BI__CFG_ConfigValue__c cfgv02 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Closed', LLC_BI__fieldValue__c = 'Booked', LLC_BI__Category__c = 'Loan Stage',LLC_BI__lookupKey__c = 'Closed');
        insert cfgv02;
        
        LLC_BI__CFG_ConfigValue__c cfgv03 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'CM_DocManLookupKey', LLC_BI__fieldValue__c = 'LLC_Loan', LLC_BI__Category__c = 'Change Memo',LLC_BI__lookupKey__c = 'CM_DocManLookupKey');
        insert cfgv03;
        
        LLC_BI__CFG_ConfigValue__c cfgv04 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'CM_DocTabLookupKey', LLC_BI__fieldValue__c = 'TB-LOAN-CREDIT', LLC_BI__Category__c = 'Change Memo',LLC_BI__lookupKey__c = 'CM_DocTabLookupKey');
        insert cfgv04;
        
        LLC_BI__CFG_ConfigValue__c cfgv05 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'CM_DocTypeLookupKey', LLC_BI__fieldValue__c = 'TY024', LLC_BI__Category__c = 'Change Memo',LLC_BI__lookupKey__c = 'CM_DocTypLookupKey');
        insert cfgv05;
        
        LLC_BI__CFG_ConfigValue__c cfgv06 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'CM_Enabled', LLC_BI__fieldValue__c = 'No', LLC_BI__Category__c = 'Change Memo',LLC_BI__lookupKey__c = 'CM_Enabled');
        insert cfgv06;
        
        LLC_BI__CFG_ConfigValue__c cfgv07 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'CM_Name', LLC_BI__fieldValue__c = 'Change Memo', LLC_BI__Category__c = 'Change Memo',LLC_BI__lookupKey__c = 'CM_Name');
        insert cfgv07;
        
        LLC_BI__CFG_ConfigValue__c cfgv08 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Complete', LLC_BI__fieldValue__c = 'Complete', LLC_BI__Category__c = 'Loan Stage', LLC_BI__lookupKey__c = 'Complete');
        insert cfgv08;
        
        LLC_BI__CFG_ConfigValue__c cfgv09 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'CreditRole', LLC_BI__fieldValue__c = 'Credit', LLC_BI__Category__c = 'General',LLC_BI__lookupKey__c = 'CreditRole');
        insert cfgv09;
        
        LLC_BI__CFG_ConfigValue__c cfgv10 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Declined', LLC_BI__fieldValue__c = 'Declined', LLC_BI__Category__c = 'Loan Status',LLC_BI__lookupKey__c = 'Declined');
        insert cfgv10;
        
        LLC_BI__CFG_ConfigValue__c cfgv11 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'DM_ReviewerRoles', LLC_BI__fieldValue__c = 'IT', LLC_BI__Category__c = 'Document Manager',LLC_BI__lookupKey__c = 'DM_ReviewerRoles');
        insert cfgv11;
        
        LLC_BI__CFG_ConfigValue__c cfgv13 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'LATEST', LLC_BI__Category__c = 'Delete_Versions_Allowed',LLC_BI__lookupKey__c = 'DELETE_VER_ALLOWED');
        insert cfgv13;
        
        LLC_BI__CFG_ConfigValue__c cfgv14 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Enabled', LLC_BI__Category__c = 'Delete_Feature_Enabled',LLC_BI__lookupKey__c = 'DEL_FEATURE_ENABLE');
        insert cfgv14;
        
        LLC_BI__CFG_ConfigValue__c cfgv15 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Qualification', LLC_BI__Category__c = 'Stages_Deletion_Allowed',LLC_BI__lookupKey__c = 'DEL_STAGES_ALLOWED');
        insert cfgv15;
        
        LLC_BI__CFG_ConfigValue__c cfgv16 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Open', LLC_BI__Category__c = 'Status_Deletion_Allowed',LLC_BI__lookupKey__c = 'DEL_STATUS_ALLOWED');
        insert cfgv16;
        
        LLC_BI__CFG_ConfigValue__c cfgv12 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'DM_AmzOrgBucketName', LLC_BI__Category__c = 'Document Manager',LLC_BI__lookupKey__c = 'DM_OrgBucketName');
        insert cfgv12;
        
        LLC_BI__CFG_ConfigValue__c cfgv33 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = '_M', LLC_BI__Category__c = 'Modification_Name_Format',LLC_BI__lookupKey__c = 'MOD_NAME_FORMAT');
        insert cfgv33;
        
        LLC_BI__CFG_ConfigValue__c cfgv34 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = '_ORG', LLC_BI__Category__c = 'Original_Name_Format',LLC_BI__lookupKey__c = 'ORG_NAME_FORMAT');
        insert cfgv34;
        
        LLC_BI__CFG_ConfigValue__c cfgv17 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'LoanTeam__c,Loan_Collateral__c,Legal_Entities__c,LLC_LoanDocument__c',LLC_BI__Category__c = 'Relatives_To_Clone', LLC_BI__lookupKey__c = 'RELATIVES_TO_CLONE');
        insert cfgv17;
        
        LLC_BI__CFG_ConfigValue__c cfgv18 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Enabled', LLC_BI__Category__c = 'Renewal_Feature_Enabled',LLC_BI__lookupKey__c = 'REN_FEATURE_ENABLE');
        insert cfgv18;
        
        LLC_BI__CFG_ConfigValue__c cfgv19 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Available', LLC_BI__Category__c = 'Renewal_History_Available_String',LLC_BI__lookupKey__c = 'REN_HIST_AVAIL_STR');
        insert cfgv19;
        
        LLC_BI__CFG_ConfigValue__c cfgv20 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'In Progress', LLC_BI__Category__c = 'Renewal_History_In_Progress_String',LLC_BI__lookupKey__c = 'REN_HIST_PROG_STR');
        insert cfgv20;
        
        LLC_BI__CFG_ConfigValue__c cfgv21 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Superceded', LLC_BI__Category__c = 'Renewal_History_Superceded_String',LLC_BI__lookupKey__c = 'REN_HIST_SUPER_STR');
        insert cfgv21;
        
        LLC_BI__CFG_ConfigValue__c cfgv22 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = '_R', LLC_BI__Category__c = 'Renewal_Name_Format',LLC_BI__lookupKey__c = 'REN_NAME_FORMAT');
        insert cfgv22;
        
        LLC_BI__CFG_ConfigValue__c cfgv23 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Booked', LLC_BI__Category__c = 'Stages_Renewal_Allowed',LLC_BI__lookupKey__c = 'REN_STAGES_ALLOWED');
        insert cfgv23;
        
        LLC_BI__CFG_ConfigValue__c cfgv24 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Closed', LLC_BI__Category__c = 'Renewal_Stage_Superceded_String',LLC_BI__lookupKey__c = 'REN_STAG_SUPER_STR');
        insert cfgv24;
        
        LLC_BI__CFG_ConfigValue__c cfgv25 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Qualification', LLC_BI__Category__c = 'Renewal_Starting_Stage',LLC_BI__lookupKey__c = 'REN_STARTING_STAGE');
        insert cfgv25;
        
        LLC_BI__CFG_ConfigValue__c cfgv26 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Open', LLC_BI__Category__c = 'Status_Renewal_Allowed',LLC_BI__lookupKey__c = 'REN_STATUS_ALLOWED');
        insert cfgv26;
        
        LLC_BI__CFG_ConfigValue__c cfgv27 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Deleted', LLC_BI__Category__c = 'Renewal_Status_Deleted_String',LLC_BI__lookupKey__c = 'REN_STATUS_DEL_STR');
        insert cfgv27;
        
        LLC_BI__CFG_ConfigValue__c cfgv28 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Superceded', LLC_BI__Category__c = 'Renewal_Status_Superceded_String',LLC_BI__lookupKey__c = 'REN_STAT_SUPER_STR');
        insert cfgv28;
        
        LLC_BI__CFG_ConfigValue__c cfgv29 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Open', LLC_BI__Category__c = 'Renewal_Starting_Status',LLC_BI__lookupKey__c = 'REN_STRTING_STATUS');
        insert cfgv29;
        
        LLC_BI__CFG_ConfigValue__c cfgv30 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Enabled', LLC_BI__Category__c = 'Renewal_Supported',LLC_BI__lookupKey__c = 'REN_SUPPORTED');
        insert cfgv30;
        
        LLC_BI__CFG_ConfigValue__c cfgv31 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'IT', LLC_BI__Category__c = 'Roles_For_Loan_Deletion',LLC_BI__lookupKey__c = 'ROLES_LOAN_DELETE');
        insert cfgv31;
        
        LLC_BI__CFG_ConfigValue__c cfgv32 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'IT', LLC_BI__Category__c = 'Roles_For_Multi-Renewal_Delete',LLC_BI__lookupKey__c = 'ROLES_MULTI_DELETE');
        insert cfgv32;
        
        LLC_BI__CFG_ConfigValue__c cfgv35 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Allowed_Status', LLC_BI__fieldValue__c = 'Open', LLC_BI__Category__c = 'Change Product',LLC_BI__lookupKey__c = '');
        insert cfgv35;        
        
        LLC_BI__CFG_ConfigValue__c cfgv36 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Allowed_Stages', LLC_BI__fieldValue__c = 'Qualification', LLC_BI__Category__c = 'Change Product',LLC_BI__lookupKey__c = '');
        insert cfgv36;
        
        LLC_BI__CFG_ConfigValue__c cfgv37 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__Category__c = 'Renewal_Fields_To_Clone',LLC_BI__lookupKey__c = 'FIELDS_TO_CLONE');
        insert cfgv37;
        
        LLC_BI__CFG_ConfigValue__c cfgv38 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Show_New_Entity_Button', LLC_BI__fieldValue__c = 'true', LLC_BI__Category__c = 'Products & Services');
        insert cfgv38;
        
        LLC_BI__CFG_ConfigValue__c cfgv39 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Show_New_Loan_Button', LLC_BI__fieldValue__c = 'true', LLC_BI__Category__c = 'Products & Services');
        insert cfgv39;
        
        LLC_BI__CFG_ConfigValue__c cfgv40 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'Show_New_Deposit_Button', LLC_BI__fieldValue__c = 'false', LLC_BI__Category__c = 'Products & Services');
        insert cfgv40;
        
        LLC_BI__CFG_ConfigValue__c cfgv41 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__Category__c = 'Entity_Check_Enabled', LLC_BI__lookupKey__c = 'REN_ENTITY_CHECK');
        insert cfgv41;
        
        LLC_BI__CFG_ConfigValue__c cfgv42 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__Category__c = 'Label', LLC_BI__lookupKey__c = 'REN_LABEL');
        insert cfgv42;
        
        LLC_BI__CFG_ConfigValue__c cfgv43 = new LLC_BI__CFG_ConfigValue__c(LLC_BI__Key__c = 'ALL', LLC_BI__fieldValue__c = 'Booked', LLC_BI__Category__c = 'Loan Stage',LLC_BI__lookupKey__c = 'Closed');
        insert cfgv43;
        
        LLC_BI__CFG_ConfigKey__c ck12 = new LLC_BI__CFG_ConfigKey__c(Name = 'KY_DM_AWSBucket', LLC_BI__lookupKey__c = 'KY_DM_AWSBucket'); insert ck12;
        
        LLC_BI__CFG_ConfigKey__c ck11 = new LLC_BI__CFG_ConfigKey__c(Name = 'KY_DM_ReviewerRoles', LLC_BI__lookupKey__c = 'KY_DM_ReviewRoles'); insert ck11;
        
        LLC_BI__CFG_ConfigKey__c ck06 = new LLC_BI__CFG_ConfigKey__c(Name = 'KY_GBL_ChangeMemo', LLC_BI__lookupKey__c = 'KY_GBL_ChangeMemo'); insert ck06;
        
        LLC_BI__CFG_ConfigKey__c ck09 = new LLC_BI__CFG_ConfigKey__c(Name = 'KY_GBL_CreditRole', LLC_BI__lookupKey__c = 'KY_GBL_CreditRole'); insert ck09;
        
        LLC_BI__CFG_ConfigKey__c ck01 = new LLC_BI__CFG_ConfigKey__c(Name = 'KY_GBL_NamespacePrefixBI', LLC_BI__lookupKey__c = 'KY_GBL_NS_PrefixBI'); insert ck01;
        
        LLC_BI__CFG_ConfigKey__c ck13 = new LLC_BI__CFG_ConfigKey__c(Name = 'KY_VER_Configuration', LLC_BI__lookupKey__c = 'KY_VER_Config'); insert ck13;
        
        List<LLC_BI__Product_Type__c> productTypes = [SELECT ID, LLC_BI__lookupKey__c FROM LLC_BI__Product_Type__c];
        LLC_BI__CFG_ConfigKey__c tempCK;
        List<LLC_BI__CFG_ConfigKey__c> referenceCK = new List<LLC_BI__CFG_ConfigKey__c>();
        for(LLC_BI__Product_Type__c pt: productTypes)
        {
            tempCK = new LLC_BI__CFG_ConfigKey__c(Name = pt.LLC_BI__lookupKey__c, LLC_BI__lookupKey__c = pt.LLC_BI__lookupKey__c);
            //insert tempCK;
            referenceCK.add(tempCK);
        }
        insert referenceCK;
        
        LLC_BI__CFG_CKJ__c ckj12 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck12.Id, LLC_BI__CFG_ConfigValue__c = cfgv12.ID); insert ckj12;
        LLC_BI__CFG_CKJ__c ckj11 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck11.Id, LLC_BI__CFG_ConfigValue__c = cfgv11.ID); insert ckj11;   
        LLC_BI__CFG_CKJ__c ckj13 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck06.Id, LLC_BI__CFG_ConfigValue__c = cfgv06.ID); insert ckj13;   
        LLC_BI__CFG_CKJ__c ckj14 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck06.Id, LLC_BI__CFG_ConfigValue__c = cfgv07.ID); insert ckj14;   
        LLC_BI__CFG_CKJ__c ckj15 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck09.Id, LLC_BI__CFG_ConfigValue__c = cfgv09.ID); insert ckj15;
        LLC_BI__CFG_CKJ__c ckj16 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck01.Id, LLC_BI__CFG_ConfigValue__c = cfgv01.ID); insert ckj16;
        LLC_BI__CFG_CKJ__c ckj17 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv34.ID); insert ckj17;
        LLC_BI__CFG_CKJ__c ckj18 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv33.ID); insert ckj18;
        LLC_BI__CFG_CKJ__c ckj19 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv02.ID); insert ckj19;
        LLC_BI__CFG_CKJ__c ckj20 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv29.ID); insert ckj20;
        LLC_BI__CFG_CKJ__c ckj21 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv30.ID); insert ckj21;
        LLC_BI__CFG_CKJ__c ckj22 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv18.ID); insert ckj22;
        LLC_BI__CFG_CKJ__c ckj23 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv17.ID); insert ckj23;
        LLC_BI__CFG_CKJ__c ckj24 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv22.ID); insert ckj24;
        LLC_BI__CFG_CKJ__c ckj25 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv26.ID); insert ckj25;
        LLC_BI__CFG_CKJ__c ckj26 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv23.ID); insert ckj26;
        LLC_BI__CFG_CKJ__c ckj27 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv25.ID); insert ckj27;
        LLC_BI__CFG_CKJ__c ckj28 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv14.ID); insert ckj28;
        LLC_BI__CFG_CKJ__c ckj29 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv15.ID); insert ckj29;
        LLC_BI__CFG_CKJ__c ckj30 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv16.ID); insert ckj30;
        LLC_BI__CFG_CKJ__c ckj31 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv20.ID); insert ckj31;
        LLC_BI__CFG_CKJ__c ckj32 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv19.ID); insert ckj32;
        LLC_BI__CFG_CKJ__c ckj33 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv21.ID); insert ckj33;
        LLC_BI__CFG_CKJ__c ckj34 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv28.ID); insert ckj34;
        LLC_BI__CFG_CKJ__c ckj35 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv24.ID); insert ckj35;
        LLC_BI__CFG_CKJ__c ckj36 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv27.ID); insert ckj36;
        LLC_BI__CFG_CKJ__c ckj37 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv32.ID); insert ckj37;
        LLC_BI__CFG_CKJ__c ckj38 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv31.ID); insert ckj38;
        LLC_BI__CFG_CKJ__c ckj39 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv13.ID); insert ckj39;
        LLC_BI__CFG_CKJ__c ckj40 = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = ck13.Id, LLC_BI__CFG_ConfigValue__c = cfgv43.ID); insert ckj40;
        
        LLC_BI__CFG_CKJ__c tempCKJ;
        List<LLC_BI__CFG_CKJ__c> referenceCKJ = new List<LLC_BI__CFG_CKJ__c>();
        if(referenceCK.size() > 0)
        {
            for(LLC_BI__CFG_ConfigKey__c cfgk: referenceCK)
            {
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv03.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv04.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv05.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv10.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv08.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv02.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv35.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv36.ID);
                referenceCKJ.add(tempCKJ);
                tempCKJ = new LLC_BI__CFG_CKJ__c(LLC_BI__CFG_ConfigKeys__c = cfgk.ID, LLC_BI__CFG_ConfigValue__c = cfgv43.ID);
                referenceCKJ.add(tempCKJ);
            }
        }
        insert referenceCKJ;
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Configuration successfully added.'));
    }
    
    public void removeConfig()
    {
        delete [SELECT ID FROM LLC_BI__CFG_CKJ__c];
        delete [SELECT ID FROM LLC_BI__CFG_ConfigKey__c];
        delete [SELECT ID FROM LLC_BI__CFG_ConfigValue__c];
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Configuration successfully removed.'));
    }
}