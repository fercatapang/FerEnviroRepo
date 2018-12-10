global with sharing class PortalUploadController {
    global PortalUploadController(){
    }

    @RemoteAction
    global static String getUserName() {
        String username = getPortalUploadUserName();
        if (username == null) {
            username = 'partneruploader@ncino.com';
        }
        return username;
    }

    private static String getPortalUploadUserName() {
        List<User> actualUser = [SELECT Username FROM User WHERE name = 'Portal UploadUser' OR Profile.Name = 'Customer Portal DocumentUploader User' OR email LIKE 'portalupload%'];
        if (actualUser != null && actualUser.size() > 0) {
            return actualUser[0].username;
        }
        return null;
    }

    @RemoteAction
    global static String getCommunityUrl() {
        String url = 'https://' + getDomain() + '/' + getCommunityPrefix();
        if (url.endsWith('/')) {
            url = url.substring(0,url.length()-1);
        }
        return url;
    }

    @RemoteAction
    global static String getNamespace() {
        String nameSpace = '';
        String[] classparts = String.valueOf(PortalUploadController.class).split('\\.');
        if (classparts.size() > 1) {
            nameSpace = classparts[0] + '__';
        }
        return namespace;
    }

    private static String getDomain() {
        String domain = [
            SELECT
                Domain
            FROM
                Domain
        ][0].Domain;
        return domain;
    }

    private static String getCommunityPrefix() {
        String prefix = [
            SELECT
                UrlPathPrefix
            FROM
                Network
            WHERE
                Name =: 'Customer Portal'
        ][0].UrlPathPrefix;

        if (prefix != null) {
            return prefix;
        }
        else {
            return '';
        }
    }

    @RemoteAction
    global static void setSystemProperties(
        String credentialName,
        String username,
        String consumerSecret,
        String consumerKey) {

        setSystemProperty('CUSTOMER_PORTAL','Document_Upload_User_Name', username, true);
        setSystemProperty('CUSTOMER_PORTAL','Document_Upload_Consumer_Key', consumerKey, true);
        setSystemProperty('CUSTOMER_PORTAL','Document_Upload_Consumer_Secret', consumerSecret, true);
        setSystemProperty('CUSTOMER_PORTAL','Document_Upload_Name_Credential_Name', credentialName, true);
    }

    global static void setSystemProperty(String category, String key, String value, Boolean active) {
        nFORCE__System_Properties__c property = new nFORCE__System_Properties__c();
        property.Name = new nFORCE.LifeCycleDataProvider().generateLookupKey();
        List<nFORCE__System_Properties__c> properties = [
            SELECT
                Name,
                nFORCE__Category_Name__c,
                nFORCE__Key__c,
                nFORCE__Value__c,
                nFORCE__Is_Active__c
            FROM
                nFORCE__System_Properties__c
            WHERE
            nFORCE__Key__c =: key
                AND
                nFORCE__Category_Name__c =: category];
        if (properties.size() > 0) {
            property = properties[0];
        }
        property.nFORCE__Category_Name__c = category;
        property.nFORCE__Key__c = key;
        property.nFORCE__Value__c = value;
        property.nFORCE__Is_Active__c = active;
        upsert property;
        nFORCE.SystemProperties.getInstance().clearCache();
    }
}