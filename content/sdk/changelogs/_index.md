---
title: "Changelogs"
date: 2022-10-18T12:59:11-04:00
draft: false
---

## Versions

- [SDK v0.9.0]({{<ref "#sdk-v090" >}}) 
- [SDK v0.8.6]({{<ref "#sdk-v086" >}}) 
- [SDK v0.7.10]({{<ref "#sdk-v0710" >}}) 
- [SDK v0.7.4]({{<ref "#sdk-v074" >}}) 
- [SDK v0.6.4]({{<ref "#sdk-v064" >}}) 

### SDK v0.9.0

**Notable Changes:**
- Change backend to use sequential sampling and seedless extraction
- Changed smallest allowed key size to 1 byte
- Simplified logging API

### SDK v0.8.6

**Notable Changes:**
- Move exceptions to QryptSecurity namespace
- Rename log level enumerations
- Update metadata schema
- Reduce library binary size

### SDK v0.7.10

**Notable Changes:**
- Add chunk multi-threading for genInit and genSync
- Increase maximum supported OTP size to 10MB

### SDK v0.7.4

**Notable Changes:**
- Improve sample retry logic for genInit and genSync
- Increase maximum supported OTP size to 512KB
- Update metadata schema

### SDK v0.6.4

**Notable Changes:**
- Initial baseline of the SDK

