@isTest
public class ConnectionTreeControllerTest {
    static testMethod void runTest() {

        Account a = new Account(
            Name = PARENT_ACCOUNT_NAME);
        insert a;

        Account c1 = new Account(
            Name = CHILD_ACCOUNT_NAME_1);
        insert c1;

        Account c2 = new Account(
            Name = CHILD_ACCOUNT_NAME_2);
        insert c2;

        LLC_BI__Connection_Role__c firstRole = new LLC_BI__Connection_Role__c(
            LLC_BI__Self_Reciprocating__c = true,
            LLC_BI__Sort_Order__c = 1);
        insert firstRole;

        LLC_BI__Connection_Role__c role = new LLC_BI__Connection_Role__c(
            LLC_BI__Sort_Order__c = 2,
            LLC_BI__Reciprocal_Role__c = firstRole.Id);
        insert role;

        LLC_BI__Connection__c con1 = new LLC_BI__Connection__c(
            LLC_BI__Connected_From__c = a.Id,
            LLC_BI__Connected_To__c = c1.Id,
            LLC_BI__Role__c = 'ROLE',
            LLC_BI__Reciprocal_Role__c = 'RECIPROCAL_ROLE',
            LLC_BI__Connection_Role__c = role.Id);
        insert con1;

        LLC_BI__Connection__c con2 = new LLC_BI__Connection__c(
            LLC_BI__Connected_From__c = a.Id,
            LLC_BI__Connected_To__c = c2.Id,
            LLC_BI__Role__c = 'ROLE',
            LLC_BI__Reciprocal_Role__c = 'RECIPROCAL_ROLE',
            LLC_BI__Connection_Role__c = role.Id);
        insert con2;

        ApexPages.StandardController stdController = new ApexPages.StandardController(a);    
        ApexPages.currentPage().getParameters().put('Id', a.Id);
        ConnectionTreeController ctrl = new ConnectionTreeController(stdController);
        String s = ctrl.getConnections();
        //PageReference pageRef = ctrl.Calculate();

        // Assert account
        System.assertEquals(PARENT_ACCOUNT_NAME, a.Name);
        // Assert first child account
        System.assertEquals(CHILD_ACCOUNT_NAME_1, c1.Name);
        // Assert second child account
        System.assertEquals(CHILD_ACCOUNT_NAME_2, c2.Name);
        // Assert first connection role
        System.assertEquals(true, firstRole.LLC_BI__Self_Reciprocating__c);
        System.assertEquals(1, firstRole.LLC_BI__Sort_Order__c);
        // Assert second connection role
        System.assertEquals(firstRole.Id, role.LLC_BI__Reciprocal_Role__c);
        System.assertEquals(2, role.LLC_BI__Sort_Order__c);
        // Assert first connection
        System.assertEquals(a.Id, con1.LLC_BI__Connected_From__c);
        System.assertEquals(c1.Id, con1.LLC_BI__Connected_To__c);
        System.assertEquals('ROLE', con1.LLC_BI__Role__c);
        System.assertEquals('RECIPROCAL_ROLE', con1.LLC_BI__Reciprocal_Role__c);
        System.assertEquals(role.Id, con1.LLC_BI__Connection_Role__c);
        // Assert second connection
        System.assertEquals(a.Id, con2.LLC_BI__Connected_From__c);
        System.assertEquals(c2.Id, con2.LLC_BI__Connected_To__c);
        System.assertEquals('ROLE',  con2.LLC_BI__Role__c);
        System.assertEquals('RECIPROCAL_ROLE', con2.LLC_BI__Reciprocal_Role__c);
        System.assertEquals(role.Id, con2.LLC_BI__Connection_Role__c);
    }

    private static final String PARENT_ACCOUNT_NAME = 'Parent Account';
    private static final String CHILD_ACCOUNT_NAME_1 = 'Child Account 1';
    private static final String CHILD_ACCOUNT_NAME_2 = 'Child Account 2';
}