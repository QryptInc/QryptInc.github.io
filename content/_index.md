+++
title = "Home"
date = 2021-10-07T14:05:15-04:00
weight = 5
disableToc = "true"
chapter = false
+++

# Qrypt Documentation

Our documentation is written by developers for developers. The goal is to make it as easy as possible for developers to use Qrypt to secure applications and infrastructure.

We believe that documentation benefits from sharing and collaborative improvement. Qrypt documentation is available on Github pages and we invite anybody to make changes or to create issues when there is content that needs to be improved.

## Integrating with Qrypt

Below is a list of the products that Qrypt offers with links to their supporting documentation.

### [Quantum Readiness](quantumreadiness/)

Quantum readiness provides centralized deployment and management UI of all Qrypt products.

### [Post quantum TLS proxy](postquantumproxy/)

This post quantum TLS proxy allows for incoming TLS connections to use post quantum cryptography.

### [Quantum Entropy](/eaas/)

Qrypt's Quantum Entropy service measures quantum effects and converts those measurements into pure random numbers. The service leverages multiple Quantum Random Number Generators (QRNGs) developed in collaboration with national and international research labs to ensure the highest quality random.

### [Key Generation](sdk/)

Qrypt SDK includes client library SDKs, cloud-based REST services, command line clients and guidance to help integrate post-quantum security into your applications and services. You can add security features to your applications without being an expert in post-quantum cryptography.

### [Portable OpenSSH with Qrypt](openssh/)

This implementation of OpenSSH has been modified to provide additional security via the Qrypt Key Generation SDK. During key exchange negotiation, the Qrypt SDK will generate an additional quantum-secure secret that is added to the session key hash inputs.
