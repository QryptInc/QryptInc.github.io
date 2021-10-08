+++
title = "Faqs"
date = 2021-10-07T14:05:15-04:00
weight = 5
disableToc = "true"
+++

**What should I do with my access token?**

Your access token is the mechanism by which your account will be charged for entropy data, and as such, it should be treated as secure and secret information (much as you would treat a password). 

**Once I receive the EaaS response, how do I obtain entropy from it?**

The EaaS service response is encoded as a JSON structure. Its “random” property will contain an array of base64-encoded strings. The “size” property specifies the length of the array, which should be the same as the size that was specified in the request (i.e., the number of kibibytes of entropy).

Each base64-encoded string can be decoded to 1,024 bytes of entropy. When all base64-encoded strings are decoded, the concatenation of all decoded bytes comprises the total requested entropy.

**What do I do if I forget my password?**

Qrypt does not have access to your password, but you can place a request to change your password.

1. Navigate to the portal at https://portal.qrypt.com/login and click the “Forgot password?” link.

2. Enter the email address associated with your account and click the “Send me the link” button.

3. Check your email for a message with further instructions.

**How do I change my password?**

1. Navigate to the portal at https://portal.qrypt.com/login and login to your account.

2. Click the account icon (top-right corner) and select “Account settings.”

3. Click the “Change password” link.

4. Enter your original password, enter a new password, and click the “Change password” button.

**How do I request a new access token?**

See section “Generate an access token” for instructions on how to request a new access token.

**I lost or forgot to save my access token. How can I retrieve it?**

To increase security, Qrypt only displays access tokens when they are first generated. If you have lost your token, you can contact Qrypt sales support at support@qrypt.com or generate a new one. 

**What happens if I have exceeded my monthly entropy quota?**

If a request is made after the monthly entropy quota has been reached, the service request will return an error code of 403.  Please contact Qrypt sales support at support@qrypt.com. 

**I need more entropy bytes per month than my current quota provides.**

To increase your quota of entropy bytes you can generate per month, either upgrade from your free account to a paid account or contact Qrypt sales support at support@qrypt.com.

**When does my entropy quota reset?**

Your quota is reset monthly on the day of the month on which you opened the account.

**What happens if my access token expires?**

After an access token expires, any requests for entropy using that token will return an error code of 401. You will need to generate a new token and use it for future entropy requests.

**How is quantum entropy different from rand, urand, grand, and other pseudorandom number generators?**

The generation of random and pseudorandom numbers is too large a topic to be covered thoroughly here, but the concepts are quite simple. There exist quantum behaviors that are completely random and unpredictable according to the laws of physics. By using a device called a homodyne laser interferometer—which can detect such quantum behaviors—Qrypt can generate and provide sequences of truly random data.

**How can I delete my Qrypt account?**

We do not currently support online cancellation of accounts. Please contact Qrypt Sales Support at support@qrypt.com to delete your account. 

**I am receiving an error response code from the Qrypt service. How do I identify the problem?**

The web service returns a status code with each response. This status code should indicate the cause of the failure. In addition to the standard HTTP error codes, the service may also return a Qrypt-specific error code, as detailed in the following table.

| Status code | Explanation and possible remediation |
| ----------- | ----------- |
| 400 | The request was invalid. Verify that the request is using the correct access token and URL, and that the requested entropy size specified in the URL is between 1 and 512. |
| 401 | Your token is invalid or has expired. Ensure the access token being used is valid or obtain a new valid token. | 
| 403 | The request has exceeded your monthly entropy quota. |
| 429 | You have exceeded the maximum number of requests (30) for the given time interval (10 seconds) with your access token. |
| 500 | The Qrypt server is experiencing issues. Please try again later. If the problem persists, please contact Qrypt Technical Support. |
| 503 | The Qrypt entropy supply is low. Please try again later. If the problem persists, please contact Qrypt Technical Support. |