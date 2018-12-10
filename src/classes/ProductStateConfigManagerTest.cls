@isTest
public class ProductStateConfigManagerTest
{
    static testMethod void controllerTestDriver()
    {
        LLC_BI__Product_Line__c pl1 = new LLC_BI__Product_Line__c(LLC_BI__lookupKey__c = 'PL001');
        insert pl1;    
        
        List<LLC_BI__Product_Type__c> pr_types = new List<LLC_BI__Product_Type__c>();
           
        LLC_BI__Product_Type__c pt1 = new LLC_BI__Product_Type__c(LLC_BI__lookupKey__c = 'PT001', LLC_BI__Product_Line__c = pl1.ID);
        pr_types.add(pt1);
        LLC_BI__Product_Type__c pt2 = new LLC_BI__Product_Type__c(LLC_BI__lookupKey__c = 'PT002', LLC_BI__Product_Line__c = pl1.ID);
        pr_types.add(pt2);
        LLC_BI__Product_Type__c pt3 = new LLC_BI__Product_Type__c(LLC_BI__lookupKey__c = 'PT003', LLC_BI__Product_Line__c = pl1.ID);
        pr_types.add(pt3);
        LLC_BI__Product_Type__c pt4 = new LLC_BI__Product_Type__c(LLC_BI__lookupKey__c = 'PT004', LLC_BI__Product_Line__c = pl1.ID);
        pr_types.add(pt4);
        
        insert pr_types;
        
        LLC_BI__Product_State_Config__c psc1 = new LLC_BI__Product_State_Config__c(LLC_BI__Product_Type__c = pt1.ID);
        insert psc1;
        LLC_BI__Product_State_Config__c psc2 = new LLC_BI__Product_State_Config__c(LLC_BI__Product_Type__c = pt1.ID);
        insert psc2;
        
        System.debug('***psc1_LK***' + psc1.LLC_BI__Product_Type__r.LLC_BI__lookupKey__c);
        System.debug('***psc1_id***' + psc1.Id);
        
        ProductStateConfigManager psc_manager = new ProductStateConfigManager();
        
        psc_manager.autoSetup();
        
        psc_manager.sourcePTGS = 'PT001';
        psc_manager.sourcePT2GS = 'PT001';
        psc_manager.targetPTGS = 'PT002,PT003';
        psc_manager.retainedPTGS= 'PT001,PT004';
        psc_manager.deletionTargetPTGS = 'PT002,PT003'; 
                
        psc_manager.insertPSCs();
        psc_manager.removeSpecifiedPSCs();
        psc_manager.insertSpecifiedPSCs();
        psc_manager.removeOtherPSCs();
        
        psc_manager.sourcePTGS = '';
        psc_manager.sourcePT2GS = '';
        psc_manager.targetPTGS = '';
        psc_manager.retainedPTGS= '';
        psc_manager.deletionTargetPTGS = ''; 
        
        psc_manager.insertPSCs();
        psc_manager.insertSpecifiedPSCs();
        psc_manager.removeSpecifiedPSCs();
        psc_manager.removeOtherPSCs();
        
        //Simulating failures using attempting SOQL Injection
        psc_manager.sourcePTGS = 'x \' LIMIT invalid';
        psc_manager.sourcePT2GS = 'x \' LIMIT invalid';
        psc_manager.targetPTGS = 'x \' LIMIT invalid';
        psc_manager.retainedPTGS= 'x \' LIMIT invalid';
        psc_manager.deletionTargetPTGS = 'x \' LIMIT invalid';
        
        psc_manager.insertPSCs();
        psc_manager.insertSpecifiedPSCs();
        psc_manager.removeSpecifiedPSCs();
        psc_manager.removeOtherPSCs();       
    }
}