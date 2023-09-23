+++
title = "PKCS11 Integration"
weight = 40
+++

This page covers the instructions to use Qrypt's quantum entropy with the PKCS11 Cryptoki interface.

## Technology Value
One of the functions to the PKCS11 Cryptoki interface is C_GenerateRandom. Many of the available implementations of this function use a pseudorandom generator. This is susceptible to post quantum attacks. Qrypt provides quantum generated random that is not susceptible to post quantum attacks. Developers can override the C_GenerateRandom function to use Qrypt's quantum entropy and still adhere to the PKCS11 standard. As a result, applications can get the benefits of quantum generated random and integrate with PKCS11 Cryptoki libraries.

## Integration Overview
{{< figure src="images/qryptoki-architecture.png" >}}

There are four components to the architecture diagram above.
1. **Client Application**: Application that depends on a PKCS11 Cryptoki library.
2. **Qrypt Cryptoki Library**: Developers will need to implement this component. All non-general-purpose functions should be passed to the *'Base Cryptoki Library'* except for the C_GenerateRandom function. The C_GenerateRandom function implementation will perform a REST API call to download Qrypt quantum random from the *'Qrypt Entropy Service'*. There will be general-purpose functions that need to be updated as well. More information will be provided in the next section.
3. **Qrypt Entropy Service**: Qrypt's service that can provide quantum random via a REST API.
4. **Base Cryptoki Library**: The PKCS11 Cryptoki library that will be provided by the HSM vendor. Alternatively, SoftHSM can be used as a software solution.

Instead of developers implementing the *'Qrypt Cryptoki Library'* component, they may choose to use the one provided by Qrypt. The source code can be found at [Qrypt-PKCS-11](https://github.com/QryptInc/Qrypt-PKCS-11/tree/main).

## Integration Instructions

### Step 1: Create a Qrypt account and generate a token for entropy
Follow the steps in the 'Getting Started' section under [Quantum Entropy](/eaas).

### Step 2: Override the C_Initialize function in the PKCS11 interface

The C_Initialize function implementation in *'Qrypt Cryptoki Library'* can read an environment variable to get the path of the *'Base Cryptoki Library'*. Afterwards, initialization of the *'Base Cryptoki Library'* can be performed.

### Step 3: Override the C_GenerateRandom function in the PKCS11 interface

#### Entropy Download
The C_GenerateRandom function implementation in *'Qrypt Cryptoki Library'* can read an environment variable to get the Qrypt Token. Afterwards, the REST API can be called for entropy download. You will need a library that can perform HTTPS requests. We recommend using libcurl. 

More information about the REST API can be found in the 'Submit a request for entropy' section under [Quantum Entropy](/eaas).

#### Managing Downloaded Random

Requests to the entropy API can only be performed in units of KiB. As a result, there may be random usage inefficiencies. Developers can choose to implement their own buffer management locally for better random utilization.
