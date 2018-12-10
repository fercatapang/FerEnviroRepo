@isTest
private class BuildBaseConfigurationTest
{
    @isTest
    static void runTest1()
    {
        LLC_BI__Product_Line__c pl01 = createProductLine('PLTEST1', 'PLTESTLK1');
        LLC_BI__Product_Type__c pt01 = createProductType('PTTEST1', 'PTTESTLK1', pl01.Id);
        LLC_BI__Product_Type__c pt02 = createProductType('PTTEST2', 'PTTESTLK2', pl01.Id);
        
        BuildBaseConfiguration config = new BuildBaseConfiguration();
        
        Test.startTest();
        config.executeConfig();
        config.removeConfig();
        Test.stopTest();
    }

    private static LLC_BI__Product_Line__c createProductLine(String pl_name, String pl_lk)
    {
        LLC_BI__Product_Line__c newPL = new LLC_BI__Product_Line__c(Name = pl_name, LLC_BI__lookupKey__c = pl_lk);
        insert newPL;
        return newPL;
    }   
    
    private static LLC_BI__Product_Type__c createProductType(String pt_name, String pt_lk, Id pline)
    {
        LLC_BI__Product_Type__c newPT = new LLC_BI__Product_Type__c(Name = pt_name, LLC_BI__lookupKey__c = pt_lk, LLC_BI__Product_Line__c = pline);
        insert newPT;
        return newPT;
    }        
}