+++
menuTitle = "Quantum Entropy"
title = "Quantum Entropy"
date = 2021-10-07T11:14:08-04:00
weight = 1
disableToc = "true"
+++

## Using Qrypt's Quantum Entropy Service

Qrypt’s Entropy as a Service is a RESTful web service that allows you to generate random data (henceforth referred to as entropy or random) that is truly random—based on quantum-mechanical phenomena.

---

## Getting Started

To start using Qrypt's Quantum Entropy service you need to create a Qrypt account, obtain an access token, and submit an HTTP request.

## Create a free Qrypt account

To request entropy from the service, you must first create an account.
{{< createFreeAccountSteps >}}

## Generate an access token

An access token is required to submit REST API requests.
{{< generateAccessTokenSteps >}}

---

## Submit a request for entropy

To get entropy from the service, you must submit an HTTP request to the REST API service, providing the aforementioned access token and specifying the number of 1,024-byte blocks of entropy you would like to receive. You must also specify an access token—which identifies the user account requesting the data—in an HTTP “authorization” header. The data is returned in a JSON-encoded structure containing an array of base64-encoded strings, each of which decodes to a 1,024-byte block of entropy, as well as an integer specifying the number of strings in the array.

{{% notice note %}}
To ensure the privacy of your access token and the entropy data, all calls are made using an encrypted HTTPS connection.
{{% /notice %}}

Follow these steps in your preferred tool or language of choice to request entropy (see subsequent sections Request and Response for details):

{{< submitRequestForEntropySteps >}}

The following sections provide more detailed explanations of the request and response.

---

## Request

The web service consists of one REST API call, which returns the entropy. The following table describes the properties of a valid REST API call.

{{< requests >}}

Qrypt’s Quantum Entropy service is hosted in several locations worldwide. This allows you to access a server that is closer to the client for better reliability and response time. The following table (Table 2) indicates which subdomain to use in your URL to access the server located in the specified region.

{{< locations >}}

---

## Response

The response from the HTTP request will contain a numeric status code indicating whether or not the request succeeded and, if not, why. If successful, it will also return the entropy.

{{< responses >}}

If a success status code of 200 was returned, the response contains a JSON-encoded structure containing an array size (which should match the kib_entropy value specified in the request) and an array of base64-encoded strings which, when decoded, contains 1,024 bytes of entropy.

{{< jsonFields >}}

The following illustrates an example of JSON output as returned by a request for two 1,024-byte blocks of entropy:

```
"random": [
  "<base64 encoding of 1,024 bytes of entropy>",
  "<base64 encoding of 1,024 bytes of entropy>"
  ],
"size": 2
```

---

## Examples

The following examples demonstrate how to submit a request and display the returned entropy.
In the following examples, _{subdomain}_ should be replaced with the subdomain for a server in the geographic location you would like to use (see Table 2), _{kib_entropy}_ should be replaced with an integer between 1 and 512, and _{qrypt_access_token}_ should be replaced with an access token generated using your Qrypt account.

## Curl

The following shows an example of how to submit a request for _{kib_entropy}_ kibibytes of entropy using the _{qrypt_access_token}_ via the _curl_ command-line command. This command can be executed at a Windows or Unix command prompt.

```
curl https://{subdomain}.qrypt.com/api/v1/quantum-entropy?size={kib_entropy} -H "Authorization: Bearer {qrypt_access_token}"
```

## PowerShell

The following shows an example of how to submit a request for _{kib_entropy}_ kibibytes of data using the _{qrypt_access_token}_ in PowerShell.

Specify entropy token, requested size of entropy, and subdomain

```
[string] $accesstoken = '{qrypt_access_token}'
```

```
[int] $kibData = {kib_entropy}
```

```
[string] $sub = '{subdomain}'
```

Define the request URL

```
[string] $url = "https://$sub.qrypt.com/api/v1/quantum-entropy?size=$kibData"
```

Define and submit the request

```
$response =  Invoke-RestMethod -Method Get -Uri $url -UseBasicParsing `-Headers @{ authorization = "Bearer $accesstoken" } ` -ContentType 'application/json'
```

Display the entropy bytes

```
response.random | foreach { [Convert]::FromBase64String($_) }
```

## Python

The following shows an example of how to submit a request for _{kib_entropy}_ kibibytes of data using the _{qrypt_access_token}_ in Python.

{{% notice note %}}
You may need to install the “requests” module before executing this example. For example, use the following command:

```
python -m pip install requests
```

{{% /notice %}}

```python
import requests
import base64

# Specify entropy token, requeststed size of entropy, and subdomain
accesstoken = '{qrypt_access_token}'
kibData = {kib_entropy}
sub = '{subdomain}'

# Define the request URL
url = f'https://{sub}.qrypt.com/api/v1/quantum-entropy'

# Define and submit the request
headers = { 'Authorization': f'Bearer {accesstoken}' }
params = { 'size': kibData }
response = requests.get( url, headers=headers, params=params)

# Display the entropy bytes
for s in response.json()['random']:
    for b in base64.decodebytes( s.encode('ascii') ):
        print( f'{b}')
```

## JavaScript

The following shows an example of how to submit a request for _{kib_entropy}_ kibibytes of data using the _{qrypt_access_token}_ in JavaScript.

```
"use strict";

// Specify entropy token, requested size of entropy, and subdomain
let accessToken = "{qrypt_access_token}";
let kibData = { kib_entropy };
let sub = "{subdomain}";

// Define the request URL
let url = `https://${sub}.qrypt.com/api/v1/quantum-entropy?size=${kibData}`;

// Submit the request and process the response
fetch(url, {
  method: "GET",
  headers: {
    Accept: "application/json",
    Authorization: "Bearer " + accessToken,
  },
})
  .then((response) => response.json())
  .then(function (json) {
    // Display the entropy bytes
    json.random.forEach((b64) =>
      [...atob(b64)].forEach((c) => console.log(c.charCodeAt(0)))
    );
  });
```
