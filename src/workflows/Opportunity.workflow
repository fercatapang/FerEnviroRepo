<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>LLC_BI__Close_Date_Moved</fullName>
        <ccEmails>Demo@Bankr.com</ccEmails>
        <description>Close Date Moved</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Workflow_Alert_Close_Date_Accelerated</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Guarantee_Fee_Not_Paid</fullName>
        <ccEmails>Demo@Bankr.com</ccEmails>
        <description>Guarantee Fee Not Paid</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Guarantee_Fee_Not_Paid</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Loan_Withdrawn_Declined</fullName>
        <ccEmails>Demo@Bankr.com</ccEmails>
        <description>Loan Withdrawn / Declined</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Loan_Withdrawn_Declined</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Order_New_Appraisal_Alert</fullName>
        <ccEmails>Demo@Bankr.com</ccEmails>
        <description>Order New Appraisal Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Order_Appraisal</template>
    </alerts>
    <alerts>
        <fullName>LLC_BI__Stage_Change_to_Compliance</fullName>
        <ccEmails>Demo@Bankr.com</ccEmails>
        <description>Stage Change to Compliance</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>LLC_BI__Bankr_Templates/LLC_BI__Stage_Change_Alert</template>
    </alerts>
    <fieldUpdates>
        <fullName>LLC_BI__Update_Start_Date_of_Current_Stage</fullName>
        <field>LLC_BI__Start_Date_at_Current_Stage__c</field>
        <formula>TODAY()</formula>
        <name>Update Start Date of Current Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>LLC_BI__Update Start Date of Current Stage</fullName>
        <actions>
            <name>LLC_BI__Update_Start_Date_of_Current_Stage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(StageName)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
