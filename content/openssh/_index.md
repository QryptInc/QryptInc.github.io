+++
menuTitle = "Qrypt OpenSSH"
title = "Portable OpenSSH with Qrypt"
date = 2021-10-18T08:59:39-04:00
weight = 30
+++

OpenSSH is a complete implementation of the SSH protocol (version 2) for secure remote login, command execution and file transfer.

## Overview

This is a port of OpenBSD's OpenSSH to most Unix-like operating systems, including Linux, OS X and Cygwin. Portable OpenSSH polyfills OpenBSD APIs that are not available elsewhere, adds sshd sandboxing for more operating systems and includes support for OS-native authentication and auditing (e.g. using PAM).

The  {{< externalLink link="https://github.com/QryptInc/openssh-portable" text="Qrypt implementation of OpenSSH" >}} has been modified to provide additional security via the Qrypt Key Generation SDK.
During key exchange (KEX) negotiation, the Qrypt SDK will generate an additional quantum-secure secret to be prepended to the session key hash inputs. Any conventional KEX algorithm can be enhanced by Qrypt security; a Qrypt-secured algorithm can be identified by the @qrypt.com suffix.

The following sections will cover the two ways of obtaining Qrypt OpenSSH; by either pulling a Docker image or building Portable OpenSSH from source with a special version of the Qrypt SDK.

## Demo Instructions

Coming soon...

## Build from source

Coming soon...
