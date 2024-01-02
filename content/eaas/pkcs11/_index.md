+++
title = "Seed PKCS#11 HSMs"
weight = 40
+++

This page covers the instructions to use Qrypt's quantum entropy to seed PKCS#11 HSMs (Hardware Security Modules).

This service requires an access token. Follow the steps in [Getting Started]({{< ref "/getting_started" >}}) to obtain an access token.

## Technology Value
Many of the available HSMs use non-quantum entropy sources. Fortunately, the PKCS#11 Cryptoki interface provides a C_SeedRandom function to inject entropy into a PKCS#11 compliant HSM. Developers can inject Qrypt's quantum entropy into the HSM using the C_SeedRandom function. As a result, HSM keys can be pseudorandomly generated from quantum entropy.

## Overview
{{< figure src="images/diagram.png" >}}

There are four components to the architecture diagram above.
1. **HSM**: Cryptographic hardware or software device that implements the PKCS#11 interface.
2. **Client Application**: Self implemented or Qrypt provided service that periodically retrieves entropy from an external source and injects it into an HSM.
3. **Qrypt Services**: Qrypt's Entropy service that can provide quantum entropy via a REST API.
4. **Cryptoki Library**: A library that the HSM vendor provides that implements the PKCS#11 interface for their device.

### Integration Steps

* Install HSM Vendor provided Cryptoki library in runtime environment's path
* Configure Client Application with a Qrypt EaaS API token to pull entropy
* Configure Client Application to authenticate with HSM per vendor instructions
* Configure Client Application to reseed as required

## Building Client Application

### Step 1: Update your client application to download Qrypt's quantum entropy
A REST API can be called for entropy download. More information about the REST API can be found in the [Submit a request for entropy]({{< ref "/eaas#submit-a-request-for-entropy" >}}) section under 'Quantum Entropy'. You will need a library that can perform HTTPS requests. 

C++ sample code using libcurl is provided in the [Quickstart](https://github.com/QryptInc/qrypt-security-quickstarts-cpp/blob/main/src/eaas.cpp). We recommend using environment variables to pass the Qrypt Token into the application.

Requests to the entropy API can only be performed in units of KiB. As a result, there may be random usage inefficiencies. Developers can choose to implement their own buffer management locally for better random utilization.

### Step 2: Update your client application to call C_SeedRandom

Sample code in C++ is shown below.

```c++
void set_seed_random(CK_SESSION_HANDLE session, CK_BYTE_PTR seed_random) {

    // Call Cryptoki interface to seed random
    CK_RV rv = C_SeedRandom(session, seed_random, sizeof(seed_random));
    if (rv != CKR_OK) {
        std::string error_msg = "C_SeedRandom error: " + std::to_string(rv) + "\n";
        throw std::runtime_error(error_msg);
    }

}
```

More information about the PKCS#11 Cryptoki interface can be found at [Oasis PKCS#11 Specification](https://docs.oasis-open.org/pkcs11/pkcs11-base/v2.40/os/pkcs11-base-v2.40-os.html).

Click [here](https://github.com/QryptInc/qseed) fgit stor a complete working example client application.