global with sharing class CreditPassReviewDecision extends nFUSE.ACreditPassReviewDecision {
	global override Flow.Interview create(Map<String,Object> inputs) {
		return new Flow.Interview.Credit_Pass_Review(inputs);
	}
}