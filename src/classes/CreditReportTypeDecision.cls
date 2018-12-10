global with sharing class CreditReportTypeDecision extends nFUSE.ACreditReportTypeDecision {
	global override Flow.Interview create(Map<String,Object> inputs) {
		return new Flow.Interview.Credit_Report_Type(inputs);
	}
}