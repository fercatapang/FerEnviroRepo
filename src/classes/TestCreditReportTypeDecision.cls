@isTest
private class TestCreditReportTypeDecision {

	@isTest static void test_implementsCreate() {
		CreditReportTypeDecision decision = new CreditReportTypeDecision();
		Map<String,Object> inputs = new Map<String,Object>();
		Test.startTest();
		Flow.Interview review = decision.create(inputs);
		Test.stopTest();
		System.assertNotEquals(null, review);
	}
}