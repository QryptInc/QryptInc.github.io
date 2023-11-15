+++
title = "NIST Entropy Quality Tests"
date = 2021-10-18T08:59:39-04:00
weight = 20
chapter = false
+++


## Using Qrypt's NIST Entropy Quality Tests

Qrypt’s NIST Entropy Quality Tests is a set of APIs that allows you to check the quality of Qrypt's entropy using the NIST Statistical Test Suite. Tests are conducted every 10 minutes against Qrypt's Quantum Entropy service. Accessing this service does not require a Qrypt account or access token. 

---
## About NIST Entropy Quality Tests
The NIST Entropy Quality Test suite uses the 15 statistical tests defined by the NIST Statistical Test Suite (STS). Each of these 15 tests is repeated over many samples. The APIs generate two test results:

1. **Total number of individual passing tests**: considered successful if a sufficient number of individual tests pass. The threshold varies based on the number of individual tests run and is based on an alpha value of 0.01. For example, 1000 individual tests requires a 98% pass rate to be considered successful.
2. **P-value uniformity for each of the 15 tests**: considered successful if all 15 tests have uniformly distributed p-values.

The tests are considered as succeeding overall if either of these criteria are met. This provides a metric for passing that is more robust to fluctuations than using either criterion alone. However, this standard does not catch certain randomness defects. For example, if the randomness was periodic with a period equal to the size used for batching, a sufficiently high portion of the tests might pass, but the P-values would not be uniform.

## NIST Entropy Quality Test Endpoints
There are three endpoints for obtaining NIST entropy quality test results. 
1. NIST Logs: retrieves a specified number of recent test results
2. Failing NIST Logs: retrieves a specified number of recent failing test results
3. Failing NIST Random: retrieves random of recent failing tests

### NIST Logs
This API contains the most recent NIST test results. To get NIST test results, you must submit an HTTP request to the API, optionally providing the number of results to view and whether they should be shown in a simplified format.

1. Make a request to the following URL: {{< externalLink link="https://nist.qrypt.com/api/v1/logs?num={num}&simple={simple}" text="https://nist.qrypt.com/api/v1/logs?num={num}&simple={simple}" >}}.
2. Optionally replace {**num**} with the desired number of recent test results to show.
3. Optionally replace {**simple**} with a true or false to specify if you want a simplified test result output.

##### Request Parameters
{{< nist/logs/requestParameters >}}

##### Response Codes
{{< nist/logs/responseCodes >}}

##### JSON Response Fields

For a successful 200 response, the response contains a JSON-encoded structure with an array of test results with the following fields in each array element. Note that the simplified logs only contain 'tests_passed', 'time_of_completion' and 'time_of_completion_string' fields. 

There are two main groupings of tests. One is prefixed 'nist' for the number of NIST STS tests that passed or failed, and the second is 'uniformity' for the uniformity of each NIST STS test's P-values.

{{< nist/logs/jsonResponseFields >}}

The following illustrates an example of JSON output as returned by a request for a single log:

```
[
    {
        "nist_all_passed": true,
        "nist_fails": 86,
        "nist_passes": 8742,
        "nist_success_rate": 0.9855783640783642,
        "tests_passed": true,
        "time_of_completion": 1699551247.1653655,
        "time_of_completion_string": "11/09/2023 12:34",
        "uniformity_all_passed": true,
        "uniformity_fails": 0,
        "uniformity_passes": 15,
        "uniformity_success_rate": 1.0
    }
]
```

### NIST Failed Test Logs
This API contains the most recent failed NIST test results, where both the individual test rate and uniformity tests fail. To get failed NIST test results, you must submit an HTTP request to the API.

1. Make a request to the following URL: {{< externalLink link="https://nist.qrypt.com/api/v1/failing_logs?num={num}&simple={simple}&strict={strict}&include_random={include_random}&randsize={randsize}" text="https://nist.qrypt.com/api/v1/failing_logs?num={num}&simple={simple}&strict={strict}&include_random={include_random}&randsize={randsize}" >}}
2. Optionally replace {**num**} with the number of recent test results to show.
3. Optionally replace {**simple**} with 'true' to output simplified logs.
4. Optionally replace {**strict**} with 'false' specify if you want to show logs that failed either the test rate or uniformity.
4. Optionally replace {**include_random**} with 'true' to see failed random. Only applicable if 'strict' is 'true'.
5. Optionally replace {**randsize**} with the number of bits to show. Only applicable if 'include_random' is set to 'true'.

##### Request Parameters
{{< nist/failing_logs/requestParameters >}}

##### Response Codes
{{< nist/failing_logs/responseCodes >}}

##### JSON Response Fields

The JSON response fields are identical to the NIST Logs API, except for the 'random' field. The 'random' field only appears if 'include_random' is set to 'true'.

{{< nist/failing_logs/jsonResponseFields >}}

The following illustrates an example of JSON output as returned by a request for a single log:

```
[
    {
        "nist_all_passed": true,
        "nist_fails": 86,
        "nist_passes": 8742,
        "nist_success_rate": 0.9855783640783642,
        "tests_passed": true,
        "time_of_completion": 1699551247.1653655,
        "time_of_completion_string": "11/09/2023 12:34",
        "uniformity_all_passed": true,
        "uniformity_fails": 0,
        "uniformity_passes": 15,
        "uniformity_success_rate": 1.0,
        "random": "111110100110010100001010100011"
    }
]
```


### NIST Failed Random
This API contains the random of the most recent strictly failing NIST tests. To get the random of failed NIST test results, you must submit an HTTP request to the API.

1. Make a request to the following URL: {{< externalLink link="https://nist.qrypt.com/api/v1/failing_random?num={num}&randsize={randsize}" text="https://nist.qrypt.com/api/v1/failing_random?num={num}&randsize={randsize}" >}}
2. Optionally replace {**num**} with the number of recent test results to show.
3. Optionally replace {**randsize**} with 'true' to output simplified logs.

##### Request Parameters
{{< nist/failing_random/requestParameters >}}

##### Response Codes
{{< nist/failing_random/responseCodes >}}

##### JSON Response Fields

{{< nist/failing_random/jsonResponseFields >}}

The following illustrates an example of JSON output as returned by a request for a single log:

```
[
    {
        "createdAt": "Thu, 09 Nov 2023 12:54:06 GMT",
        "random": "111110100110010100001010100011",
        "time_of_completion": 1699534446.5982661
    }
]
```
