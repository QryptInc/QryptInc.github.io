+++
title = "Overview"
date = 2021-10-18T08:59:57-04:00
weight = 10
chapter = false
+++

Developers need familiar tools based on modern development practices. We provide an SDK that can be easily integrated to applications and infrastructure to make them quantum-secure.

The Qrypt SDK includes client library SDKs, cloud-based REST services, command line clients and guidance to help integrate post-quantum security into your applications and services. You can add security features to your applications without being an expert in post-quantum cryptography. 

#### Qrypt SDK for C++

**Features**
* local key generation
* distributed key generation 

**Library Compatibility**

The C++ SDK is built using the following compilers.

| Platform | Compiler | CPU
|---|---|---|
| Linux | Clang 9.0.0 | x64 |
| Macos | AppleClang 12.0.0.12000032 | x64 |
| Windows | Clang 9.0.0 with MSVC-like command-line | x64 |

{{% notice warning %}}
The Qrypt Security Linux SDK v0.5.2 and earlier is compatible with CentOS 7 only. The next release will migrate compatibility to modern versions of Fedora and Ubuntu.
{{% /notice %}}
