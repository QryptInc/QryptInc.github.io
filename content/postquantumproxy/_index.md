+++
menuTitle = "Post quantum TLS proxy"
title = "Post quantum TLS proxy"
date = 2024-09-24T08:59:39-04:00
weight = 31
disableToc = "true"
+++

## Overview

This post quantum TLS proxy combines nginx, oqs OpenSSL, wireguard, and our quantum readiness orchestrator. This can be a stand alone proxy to serve content through traditional nginx configurations.

### Setup

There are some exposed environment variables to set the default nginx algorithms. See below.
```
DEFAULT_GROUPS: x25519:x448:kyber512:p256_kyber512:kyber768:p384_kyber768:kyber1024:p521_kyber1024
DEFAULT_SIG_ALGS: dilithium3:dilithium5
DEFAULT_CIPHERS: TLS_CHACHA20_POLY1305_SHA256
MIN_PROTOCOL: TLSv1.3
```

It also uses a config file at /opt/nginx/example.conf. This config controls the log level and quantum readiness connection.

A container image is provided and it can be simply run with `docker run -i -t --rm crypto-agility-orchestrator:latest sh` to interact with.

Please reach out to [Qrypt](https://www.qrypt.com/contact/) for a demo or more information.
