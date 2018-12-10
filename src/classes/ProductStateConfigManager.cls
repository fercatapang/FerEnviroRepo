public with sharing class ProductStateConfigManager
{
    public String sourcePTGS {get;set;}
    public String sourcePT2GS {get;set;}
    public String targetPTGS {get; set;}
    public String retainedPTGS {get; set;}
    public String deletionTargetPTGS {get; set;}
    
    List<String> listProductTypeStrings = new List<String>();
    List<String> listTargetPscStrings = new List<String>();
    List<String> listSourcePscStrings = new List<String>();
    
    public List<LLC_BI__Product_Type__c> productTypesGS {get;set;}
    
    transient Savepoint sp;
    
    public void autoSetup()
    {
        String ptqry = getCreatableFieldsSOQL('LLC_BI__Product_Type__c','Name != null');
        List<LLC_BI__Product_Type__c> pt = Database.query(ptqry);
        productTypesGS = pt;
    }

    /*** METHOD TO INSERT ALL PRODUCT STATE CONFIGS -- SPECIFY A SINGLE SOURCE AND IT WILL COPY ACROSS ALL PRODUCT TYPES ***/
    public void insertPSCs()
    {
        try
        {
            sp = Database.setSavepoint();
            String sourcePT = sourcePTGS; //ie, PT-Com-RE
            if (sourcePT.length() == 0 || sourcePT == '' || sourcePT.contains(','))
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter a single source Product Type lookupKey (without commas).'));
            }
            else
            {
                List<LLC_BI__Product_State_Config__c> psconfig = new List<LLC_BI__Product_State_Config__c>();
                String pscQuery = getCreatablePSCFieldsSOQL('LLC_BI__Product_State_Config__c','LLC_BI__Product_Type__r.LLC_BI__lookupKey__c = ' + '\'' + sourcePT + '\'');
                List<LLC_BI__Product_State_Config__c> productStateConfigs = Database.query(pscQuery);
                List<LLC_BI__Product_Type__c> productTypes = [SELECT ID, LLC_BI__lookupKey__c FROM LLC_BI__Product_Type__c WHERE LLC_BI__lookupKey__c != :sourcePT];
                
                LLC_BI__Product_State_Config__c tempPSC;
                for(LLC_BI__Product_Type__c pt: productTypes) //for each product type...
                {
                    for(LLC_BI__Product_State_Config__c psc: productStateConfigs) //...add each product state config
                    {
                        tempPSC = psc.clone(false, false, false, false); //straightforward clone operation; field-agnostic
                        tempPSC.LLC_BI__Product_Type__c = pt.ID;
                        tempPSC.LLC_BI__lookupKey__c = generateRandomString(7);                
                        psconfig.add(tempPSC);  
                    }
                }
                insert psconfig;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'PSCs inserted successfully.'));
                //successReset();
            }
        }
        catch(Exception e)
        {
            Database.rollback(sp); //All changes are rolled back in the event of an error.
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'PSC could not be inserted.  SF error:  ' + e));
        }
    }
    
    
    /*** METHOD TO INSERT PRODUCT STATE CONFIGS INTO SPECIFIED TARGETS ***/
    public void insertSpecifiedPSCs()
    {
        try
        {
            sp = Database.setSavepoint();
            String sourcePT = sourcePT2GS; //ie, PT-Com-RE
            String targetPT = targetPTGS;
            if (sourcePT.length() == 0 || targetPT.length() == 0 || sourcePT.contains(','))
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter both a source Product Type lookupKey (without commas) and target Product Type lookupKey(s).'));
            }
            else
            {
                parseProductTypeTarget(targetPT);
                String queryWhereClause = 'LLC_BI__lookupKey__c = ';
                Integer count = 1;
                for(String target : listProductTypeStrings)
                {
                    queryWhereClause += '\'' + target + '\'';
                    count++;
                    if(count <= listProductTypeStrings.size())
                    {
                        queryWhereClause += ' OR LLC_BI__lookupKey__c = ';
                    }
                }
                
                List<LLC_BI__Product_State_Config__c> psconfig = new List<LLC_BI__Product_State_Config__c>();
                String pscQuery = getCreatablePSCFieldsSOQL('LLC_BI__Product_State_Config__c','LLC_BI__Product_Type__r.LLC_BI__lookupKey__c = ' + '\'' + sourcePT + '\'');
                List<LLC_BI__Product_State_Config__c> productStateConfigs = Database.query(pscQuery);
                
                String ptQuery = 'SELECT ID, LLC_BI__lookupKey__c FROM LLC_BI__Product_Type__c WHERE ' + queryWhereClause;
                List<LLC_BI__Product_Type__c> targetProductTypes = Database.query(ptQuery);              
        
                LLC_BI__Product_State_Config__c tempPSC;
                for(LLC_BI__Product_Type__c pt: targetProductTypes) //for each product type...
                {
                    integer testcount = 0;
                    for(LLC_BI__Product_State_Config__c psc: productStateConfigs) //...add each product state config
                    {
                        System.debug('***datetime-' + testcount + '*** ' + Datetime.now().getTime());
                        testcount++;
                        tempPSC = psc.clone(false, false, false, false); //straightforward clone operation; field-agnostic
                        tempPSC.LLC_BI__Product_Type__c = pt.ID;
                        tempPSC.LLC_BI__lookupKey__c = generateRandomString(7);                
                        psconfig.add(tempPSC);  
                    }
                }
                insert psconfig;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'PSCs inserted successfully.'));
                //successReset();
            }
            
        }
        catch(Exception e)
        {
            Database.rollback(sp); //All changes are rolled back in the event of an error.
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'PSC could not be inserted.  SF error:  ' + e));
        }
    }
    
    
    /*** METHOD TO DELETE ONLY SPECIFIED PRODUCT STATE CONFIGS BY PRODUCT TYPE ***/
    public void removeSpecifiedPSCs()
    {
        try
        {
            sp = Database.setSavepoint();
            String deletionTargetPT = deletionTargetPTGS;
            if (deletionTargetPT.length() == 0)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter at least one target Product Type lookupKey. Comma-separated values are allowed.'));
            }
            else
            {
                parsePscTarget(deletionTargetPT);
                String queryWhereClause = 'LLC_BI__Product_Type__r.LLC_BI__lookupKey__c = ';
                Integer count = 1;
                for(String target : listTargetPscStrings)
                {
                    queryWhereClause += '\'' + target + '\'';
                    count++;
                    if(count <= listTargetPscStrings.size())
                    {
                        queryWhereClause += ' OR LLC_BI__Product_Type__r.LLC_BI__lookupKey__c = ';
                    }
                }
                
                String psQuery = 'SELECT ID, LLC_BI__lookupKey__c FROM LLC_BI__Product_State_Config__c WHERE ' + queryWhereClause;
                List<LLC_BI__Product_State_Config__c> targetPSCs = Database.query(psQuery);              
        
                delete(targetPSCs);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Targeted PSCs removed successfully.'));
                //successReset();
            }
            
        }
        catch(Exception e)
        {
            Database.rollback(sp); //All changes are rolled back in the event of an error.
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'PSCs could not be removed.  SF error:  ' + e));
        }
    }
    
    
    /*** METHOD TO DELETE ALL PRODUCT STATE CONFIGS, BUT INCLUDE SOURCES TO KEEP ***/
    public void removeOtherPSCs()
    {
        try
        {
            sp = Database.setSavepoint();
            String retainedPT = retainedPTGS;
            if(retainedPTGS.length() == 0)
            {
                retainedPT = 'none_specified';
            }
            else
            {
                retainedPT = retainedPTGS;
            }

            parsePscSources(retainedPT);
            String queryWhereClause = 'LLC_BI__Product_Type__r.LLC_BI__lookupKey__c != ';
            Integer count = 1;
            for(String target : listSourcePscStrings)
            {
                queryWhereClause += '\'' + target + '\'';
                count++;
                if(count <= listSourcePscStrings.size())
                {
                    queryWhereClause += ' AND LLC_BI__Product_Type__r.LLC_BI__lookupKey__c != ';
                }
            }
 
            String psQuery = 'SELECT ID, LLC_BI__lookupKey__c FROM LLC_BI__Product_State_Config__c WHERE ' + queryWhereClause;
            List<LLC_BI__Product_State_Config__c> targetPSCs = Database.query(psQuery);  
 
            delete(targetPSCs);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Unspecified PSCs removed successfully.'));
            //successReset();
        }
        catch(Exception e)
        {
            Database.rollback(sp); //All changes are rolled back in the event of an error.
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'PSCs could not be removed.  SF error:  ' + e));
        }
    }
    
    
    /*** METHOD TO RETURN A DYNAMIC SOQL QUERY BASED ON THE PASSED OBJECT -- INCLUDES ALL FIELDS ***/
    public static string getCreatableFieldsSOQL(String objectName, String whereClause)
    {       
        String selects = '';  
        if (whereClause == null || whereClause == '')
        { 
            return null;
        }
         
        //Get a map of field name and field token
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
        if (fMap != null)
        {
            for (Schema.SObjectField ft : fMap.values()) //loop through all field tokens (ft)
            {
                Schema.DescribeFieldResult fd = ft.getDescribe(); //describe each field (fd)
                //if (fd.isCreateable()){ // field is creatable
                selectFields.add(fd.getName());
                //}
            }
        }
         
        if (!selectFields.isEmpty())
        {
            for (string s:selectFields)
            {
                selects += s + ',';
            }
            if (selects.endsWith(','))
            {
                selects = selects.substring(0,selects.lastIndexOf(','));
            }           
        }        
        system.debug('**query** : ' + 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause);
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;        
    }

    /*** METHOD TO RETURN A DYNAMIC SOQL QUERY, TAILORED TO PSC OBJECT -- INCLUDES ALL FIELDS ***/
    public static string getCreatablePSCFieldsSOQL(String objectName, String whereClause)
    {       
        String selects = '';  
        if (whereClause == null || whereClause == '')
        { 
            return null;
        }
         
        //Get a map of field name and field token
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
        if (fMap != null)
        {
            for (Schema.SObjectField ft : fMap.values()) //loop through all field tokens (ft)
            {
                Schema.DescribeFieldResult fd = ft.getDescribe(); //describe each field (fd)
                //if (fd.isCreateable()){ // field is creatable
                selectFields.add(fd.getName());
                //}
            }
        }
         
        if (!selectFields.isEmpty())
        {
            for (string s:selectFields)
            {
                selects += s + ',';
            }
            if (selects.endsWith(','))
            {
                selects = selects.substring(0,selects.lastIndexOf(','));
            }           
        }        
        system.debug('**query** : ' + 'SELECT ' + selects + ', LLC_BI__Product_Type__r.LLC_BI__lookupKey__c FROM ' + objectName + ' WHERE ' + whereClause);
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;        
    }      
    
    /*** METHODS TO SPLIT ALL SOURCE & TARGET PRODUCT TYPES INTO INDIVIDUAL STRINGS, BASED ON COMMAS ***/
    public void parseProductTypeTarget(String target)
    {
        listProductTypeStrings = target.split(',', target.CountMatches(',') + 1); //looking for commas to separate strings
    }
    
    public void parsePscTarget(String target)
    {
        listTargetPscStrings = target.split(',', target.CountMatches(',') + 1); //looking for commas to separate strings
    }
    
    public void parsePscSources(String target)
    {
        listSourcePscStrings = target.split(',', target.CountMatches(',') + 1); //looking for commas to separate strings
    }
    
    
    /*** METHOD TO GENEREATE A RANDOM STRING TO SERVE AS PSC LOOKUPKEYS ***/
    public static String generateRandomString(Integer len)
    {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        String randStr = '';
        while (randStr.length() < len) 
        {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        randStr = randStr + Datetime.now().getTime();
        return randStr; 
    }
    
    /*
    public PageReference successReset() 
    {
        PageReference pg = apexpages.Currentpage();
        //pg.setRedirect(false);
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Success!'));
        apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,'SUCCESS!');
        apexpages.addmessage(msg);
        return pg;
    }
    */
}