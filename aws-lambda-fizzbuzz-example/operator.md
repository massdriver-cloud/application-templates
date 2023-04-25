# Operator Guide

## Resources

* AWS Lambda Function running a basic fizzbuzz solver written in NodeJS
* An API Gateway Path `/fizzbuzz` setup for post requests in the following format:

```json
{
  "query": {{number_to_test}}
}
```

* An API Gateway Deployment which will make Lambda changes live on deployment of the individual function

## Alarms

The template comes with alarms and metrics configured for Lambda out of the box. Configured Alarms:

* Error rate: The total number of errors divided by the number of total invocations. These errors can be runtime errors or execution timeouts.
* Average Duration: Configured to report on average duration of Lambda executions and alarm when the duration exceeds 80% of the currently defined execution timeout.
* Maximum Duration: Duration of the longest Lambda execution duration during a rolling window. The alarm will alert when the max duration reaches the execution timeout duration.
