+++
menuTitle = "Qrypt OpenSSH"
title = "Portable OpenSSH with Qrypt"
date = 2021-10-18T08:59:39-04:00
weight = 30
+++

OpenSSH is a complete implementation of the SSH protocol (version 2) for secure remote login, command execution and file transfer. Our Qrypt modifications add a dash of quantum-secure.

## Overview

Portable OpenSSH is a port of OpenBSD's OpenSSH to most Unix-like operating systems, including Linux, OS X and Cygwin. It polyfills OpenBSD APIs that are not available elsewhere, adds sshd sandboxing for more operating systems and includes support for OS-native authentication and auditing (e.g. using PAM).

The [Qrypt implementation of OpenSSH](https://github.com/QryptInc/openssh-portable) has been modified to provide additional security via the Qrypt Key Generation SDK.
During key exchange (KEX) negotiation, the Qrypt SDK will generate an additional quantum-secure secret to be prepended to the session key hash inputs. Any conventional KEX algorithm can be enhanced by Qrypt security; a Qrypt-secured algorithm can be identified by the @qrypt.com suffix.

The following sections will cover the two ways of obtaining Qrypt OpenSSH; by either pulling a Docker image and creating a demo container, or building Portable OpenSSH from source with a special version of the Qrypt SDK.

## Instructions to create a demo container

First, visit the [Qrypt portal](https://portal.qrypt.com), make a free account, and generate a keygen token.

### Set up sshd terminal:
- Pull the Docker image: `docker pull qryptdev001/openssh:0.1.0`
- Run docker container in interactive mode: `docker run -it --entrypoint bash --rm --name democontainer qryptdev001/openssh:0.1.0`
- Paste your token into the environment: `export TOKEN=<token>`
- Run sshd: `$(which sshd) -o QryptToken=$TOKEN`
  - Add the `-d` flag to enable verbose logging and automatically close sshd at the end of the session.

### Set up ssh/sftp terminal:
- Open a second interactive session in the running container: `docker exec -it democontainer bash`
- Paste your token into the environment: `export TOKEN=<token>`
- Run ssh or sftp: `<ssh/sftp> -o QryptToken=$TOKEN sftpuser@127.0.0.1`
  - Add the `-v` flag to enable verbose logging.
- Log into sftpuser with the password "pass"

### (Optional) Rebuild OpenSSH to enable hex printouts of key material and metadata
```bash
`cd /root/openssh-portable`
`sed -i ':a;N;$!ba;s/#define KEX_H\n/#define KEX_H\n\n#define DEBUG_KEX\n/g' kex.h` # Set DEBUG_KEX flag
`make clean`
`make`
`make install`
```
Run sshd, sftp, and/or ssh using the instructions above.

## Instructions to build from source

Follow the instructions found in the [README](https://github.com/QryptInc/openssh-portable/blob/master/README.md), under the "Build with QryptSecurityC" header. This requires the currently-unavailable QryptSecurityC SDK, which is still being prepared for public use. Check back here soon!
