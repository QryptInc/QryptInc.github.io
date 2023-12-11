---
title: "Changelogs"
date: 2022-10-18T12:59:11-04:00
draft: false
---

## Versions

1. [SDK v0.11.19]({{<ref "#sdk-v01119" >}})
2. [SDK v0.11.14]({{<ref "#sdk-v01114" >}})
3. [SDK v0.11.6]({{<ref "#sdk-v0116" >}})
4. [SDK v0.10.2]({{<ref "#sdk-v0102" >}})
5. [SDK v0.9.2]({{<ref "#sdk-v092" >}})
6. [SDK v0.8.6]({{<ref "#sdk-v086" >}})
7. [SDK v0.7.10]({{<ref "#sdk-v0710" >}})
8. [SDK v0.7.4]({{<ref "#sdk-v074" >}})
9. [SDK v0.6.4]({{<ref "#sdk-v064" >}})

---
### SDK v0.11.19
**Notable Changes:**

1. Upgrading SDK build from Ubuntu 20.04 to Ubuntu 22.04
2. Upgrading SDK build from gcc 9.4.0 to gcc 11.4.0

---
### SDK v0.11.14
**Notable Changes:**

1. Upgrading OpenSSL dependency to 3.1.4 and libcurl dependency to 8.2.1
2. Fixing verification for corrupted metadata

---
### SDK v0.11.6
**Notable Changes:**

*This release contains breaking API changes*

1. Updating metadata schema (no longer compatible with previous versions)
2. Adding public HTTPS client interface
3. Upgrading to C++ 17
4. Upgrading OpenSSL dependency to 1.1.1v and flatbuffers dependency to 23.5.26

---
### SDK v0.10.2
**Notable Changes:**

*This release contains breaking API changes*

1. Simplify keygen genInit API to use key sizes and remove key mode
2. Add customizable TTL in genInit
3. Upgrade OpenSSL dependency to 1.1.1t and libcurl dependency to 8.0.0

---

### SDK v0.9.2
**Notable Changes:**

1. Change backend to use sequential sampling and seedless extraction
2. Change smallest allowed key size to 1 byte
3. Simplify logging API

---

### SDK v0.8.6

**Notable Changes:**

1. Move exceptions to QryptSecurity namespace
2. Rename log level enumerations
3. Update metadata schema
4. Reduce library binary size

---

### SDK v0.7.10

**Notable Changes:**

1. Add chunk multi-threading for genInit and genSync
2. Increase maximum supported OTP size to 10MB

---

### SDK v0.7.4

**Notable Changes:**

1. Improve sample retry logic for genInit and genSync
2. Increase maximum supported OTP size to 512KB
3. Update metadata schema

---

### SDK v0.6.4

**Notable Changes:**

1. Initial baseline of the SDK

---
