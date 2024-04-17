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
During key exchange (KEX) negotiation, the Qrypt SDK will generate an additional quantum-secure secret to be prepended to the session key hash inputs. Any conventional KEX algorithm can be enhanced by Qrypt security; a Qrypt-secured algorithm can be identified by the ***@qrypt.com*** suffix.

Currently availble Qrypt KEX algorithms:

{{< availableKex >}}

The following sections will cover the two ways of obtaining Qrypt OpenSSH; by either downloading a Docker Compose file and using it to build a demo cluster, or building Portable OpenSSH from source and adding a version of the Qrypt SDK with a C wrapper.

## Instructions to create a demo cluster

First, visit the [Qrypt portal](https://portal.qrypt.com), make a free account, and generate a keygen token.
Then, download our Docker Compose file [here](/docker-compose.yaml), and paste your token at the location labeled ***\<PASTE-TOKEN-HERE>***

In your terminal, run `docker-compose up --build` to build both the sshd server and the ssh/sftp client. The terminal will run the ***sshd-server*** container and print its debug outputs. To terminate the cluster, press Ctrl+C.

When you're finished with the demo, if you'd like to remove the cluster, run `docker-compose down` and all associated Docker containers and their network will be deleted.

### SSH Demo

In a new terminal, run `docker exec -it ssh-client bash` to open an interactive terminal in the ***ssh-client*** container, which is equipped with both ssh and sftp.
In this container:

```bash
export TOKEN=<PASTE-TOKEN-HERE> # Paste your token into the environment
ssh -v -o QryptToken=$TOKEN sshuser@sshd-server.com # Log in to sshd-server.com as the user "sshuser"
```

The default password for sshuser is "pass".
Verbose logging will print a line indicating the KEX algorithm used, and that algorithm's name will end in ***@qrypt.com***, showing that it is Qrypt-modified.

To show that we're now logged into the server:
```bash
bash # Change to a shell that shows the current user, the container name, and the current working directory
exit # Exit Bash (when you're done on the server)
exit # Exit sshd-server
```

### SFTP Demo

Assuming you are still in the ***ssh-client*** container:

```bash
echo "0123456789abcdef" > testfile # Create a file to push up to the server
sftp -v -o QryptToken=$TOKEN sshuser@sshd-server.com # Open an sftp session
```

The default password for sshuser is still "pass".
Verbose logging will print a line indicating the KEX algorithm used, and that algorithm's name will end in ***@qrypt.com***, showing that it is Qrypt-modified.

To send a file with sftp:
```bash
cd /sftp/sshuser/upload # Navigate to the user's upload directory
ls # Show that the directory is empty
put testfile # Upload the file
ls # Show that the file is now in the upload directory
```

To verify the test file, open a new terminal and navigate to the file on the server:
```bash
docker exec -it sshd-server bash # Open an interactive terminal the sshd server
cd /sftp/sshuser/upload # Navigate to sshuser's upload directory
ls # Show the file in the directory
cat testfile # Print the file contents (0123456789abcdef)
```

### (Optional) Rebuild OpenSSH to enable logging hex printouts of key material and metadata

In either container:

```bash
cd /root/openssh-portable
sed -i ':a;N;$!ba;s/#define KEX_H\n/#define KEX_H\n\n#define DEBUG_KEX\n/g' kex.h # Set DEBUG_KEX flag
make clean
make
make install
```
To see changes in the server's logging, it must be restarted after the above commands are run in its container.
To see changes in the client's on connection logging, you must reconnect after the above commands are run in its container.

## Instructions to build from source

Follow the instructions found in the [README](https://github.com/QryptInc/openssh-portable/blob/master/README.md), under the "Build with QryptSecurityC" header. This requires the currently-unavailable QryptSecurityC deliverable (the Qrypt SDK with a C wrapper), which is still being prepared for public use. Check back here soon!
