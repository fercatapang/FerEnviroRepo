@isTest
private class TestCreditPassReviewDecision {

	@isTest static void test_implementsCreate() {
		CreditPassReviewDecision decision = new CreditPassReviewDecision();
		Map<String,Object> inputs = new Map<String,Object>();
		Test.startTest();
		Flow.Interview review = decision.create(inputs);
		Test.stopTest();
		System.assertNotEquals(null, review);
	}
}