public with sharing class ConnectionTreeController {
   public Id accountId {get; private set;}
   
   public ConnectionTreeController(ApexPages.StandardController stdController) {
       Account currentAccount = (Account)stdController.getRecord();
       accountId = currentAccount.Id;
  }

  public String getConnections() {
       List<LLC_BI__Connection__c> connections = [SELECT
               Id,
               LLC_BI__Connected_From__c,
               LLC_BI__Connected_From__r.Name,
               LLC_BI__Connected_To__c,
               LLC_BI__Connected_To__r.Name,
               LLC_BI__Connection_Role__c,
               LLC_BI__Connection_Role__r.Name,
               LLC_BI__Status__c,
               LLC_BI__Type__c,
               LLC_BI__Ownership_Percent__c
           FROM
               LLC_BI__Connection__c
           WHERE
               LLC_BI__Connected_From__c =: accountId];

       String ret = '[';
      
      for (LLC_BI__Connection__c c : connections) {
         ret += new RowData(c).toJsonString();
      }
      ret += ']';
      
      return ret;
  }

   public class RowData {
     public String id;
     public String name;
     public String accName;
     public String parentId;
     public String tooltip;
     public Decimal description;
     public String accountType;
     public String role;
     public String type;
     public Id highest;
     public Id accId;
     
     public RowData(LLC_BI__Connection__c connection) {
       this.id = connection.LLC_BI__Connected_To__c;
       this.name = connection.LLC_BI__Connected_To__r.Name;
       this.parentId = connection.LLC_BI__Connected_From__r.Name;
       this.highest = connection.LLC_BI__Connected_From__c;
       this.role = connection.LLC_BI__Connection_Role__r.Name;
       this.type = connection.LLC_BI__Type__c;
       this.description = connection.LLC_BI__Ownership_Percent__c;
     }

       public String toJsonString() {
           String returnString = '[{v: "'+id+'", f: \'<a href="/'+id+'" target="_parent">'+name+'</a><br />';
         returnString += '<div style="color:blue; font-style:italic">'+role+'</div>';

        returnString += (type != 'Household' ? + type : '')
            + '\'}, "'+(parentId != null ? parentId : '')
               + '"," Ownership: ' +(description != null ? description : 0)+'%"],';
         
         return returnString;
      }
   }
}