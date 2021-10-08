+++
title = "Entropy as a Service"
date = 2021-10-07T11:14:08-04:00
weight = 1
disableToc = "true"
+++

## Using Qrypt Entropy as a Service
Qrypt’s Entropy as a Service is a RESTful web service that allows you to generate random data (henceforth referred to as entropy or random) that is truly random—based on quantum-mechanical phenomena.

### Getting Started

To start using Qrypt Entropy as a Service, you need to create a Qrypt account, obtain an access token, and submit an HTTP request.

#### Create a free Qrypt account
To request entropy from the service, you must first create an account.

1. Navigate to https://portal.qrypt.com and select the option to create a new account.

2. Enter your email address and a strong password, then click the button to create your account.

3. Check your email for the 4-digit account confirmation code and enter it on the website to confirm your account.

4. When prompted, enter your first and last name.

#### Generate an access token

An access token is required to submit REST API requests.

1. Navigate to the Tokens page.

2. Assign a name to the token to help you distinguish between different tokens.

3. Select the expiration period. This determines when the token will expire and need to be replaced.

4. Click the “Generate token” button.

5. The generated token will be displayed along with an example of how entropy data can be requested. Copy the token using the “Copy” button and store it in a secure location. Important: This is the only time you will be able to view the access token. Be sure to copy and store it before closing this popup.

6. Save the access token to a secure location. Because your access token is used to make requests for entropy—a budgeted resource—it should be treated as secure data, very much like a password.

#### Submit a request for entropy

To get entropy from the service, you must submit an HTTP request to the REST API service, providing the aforementioned access token and specifying the number of 1,024-byte blocks of entropy you would like to receive. You must also specify an access token—which identifies the user account requesting the data—in an HTTP “authorization” header. The data is returned in a JSON-encoded structure containing an array of base64-encoded strings, each of which decodes to a 1,024-byte block of entropy, as well as an integer specifying the number of strings in the array.

```
Note: To ensure the privacy of your access token and the entropy data, all calls are made using an encrypted HTTPS connection.
```

Follow these steps in your preferred tool or language of choice to request entropy (see subsequent sections Request and Response for details):

1. Specify your access token and the desired number of kibibytes (1,024 bytes) of entropy in a web request. Use the following URL: https://api-eus.qrypt.com/api/v1/quantum-entropy?size={kib_entropy}

2. Replace {kib_entropy} in the aforementioned URL with an integer indicating the number of kibibytes of entropy to return.

3. Include an HTTP “Accept” header field with a value of “application/json”.

4. Include an HTTP “Authorization” header with a value of “Bearer {access_token}”, where {access_token} is the access token obtained from the Qrypt portal.

5. Submit the HTTP request using the HTTP GET method.

6. If the HTTP request is successful, the JSON-formatted response will contain a structure containing two fields named “random” and “size”. The “random” field contains an array of base64-encoded strings (each of which—when decoded—contains 1,024 bytes of entropy). The “size” field contains the number of elements in the “random” field.

The following sections provide more detailed explanations of the request and response.

### Request

The web service consists of one REST API call, which returns the entropy. The following table describes the properties of a valid REST API call. 

{{< requests >}}

### Response

The response from the HTTP request will contain a numeric status code indicating whether or not the request succeeded and, if not, why. If successful, it will also return the entropy.

{{< responses >}}

If a success status code of 200 was returned, the response contains a JSON-encoded structure containing an array size (which should match the kib_entropy value specified in the request) and an array of base64-encoded strings which, when decoded, contains 1,024 bytes of entropy.

{{< jsonFields >}}