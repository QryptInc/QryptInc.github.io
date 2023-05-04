---
title: "Changelogs"
date: 2022-10-18T12:59:11-04:00
draft: false
---

## Versions

1. [SDK v0.10.2]({{<ref "#sdk-v0102" >}})
2. [SDK v0.9.2]({{<ref "#sdk-v092" >}})
3. [SDK v0.8.6]({{<ref "#sdk-v086" >}})
4. [SDK v0.7.10]({{<ref "#sdk-v0710" >}})
5. [SDK v0.7.4]({{<ref "#sdk-v074" >}})
6. [SDK v0.6.4]({{<ref "#sdk-v064" >}})

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
