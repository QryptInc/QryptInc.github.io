+++
title = "Quickstart: Local Key Generation"
date = 2021-10-18T09:01:22-04:00
weight = 20
chapter = false
+++

## Sample Code

Find the finalized code for this quickstart on {{< externalLink link="https://github.com/QryptInc/qrypt-security-quickstarts-cpp" text="GitHub" >}}

## Prerequisites
- A Qrypt Account. {{< externalLink link="https://portal.qrypt.com/register" text="Create an account for free" >}}.
- Install {{< externalLink link="https://cmake.org/" text="CMake" >}}
- (Windows) Install git bash - comes with typical git install.
- (Optional) Install {{< externalLink link="https://code.visualstudio.com/" text="Visual Studio Code" >}}.

# Setup
1. Clone the repo containing this quickstart to a local folder on a Linux, Mac or Windows platform.
1. Retrieve a token from the {{< externalLink link="https://portal.qrypt.com/tokens" text="Qrypt Portal" >}}
1. (Optional) Create an environment variable **QRYPT_TOKEN** for it. For simplicity, the commands below will be referencing a **QRYPT_TOKEN** environment variable but you can also just use the token direclty in the commands below.
1. Download the Qrypt Security SDK from the {{< externalLink link="https://portal.qrypt.com/downloads/sdk-downloads" text="Qrypt Portal" >}} for your platform.

**Linux/Windows**
1. Verify the lib folder exists and extract the Qrypt Security SDK into it.

*Expected Folder structure (Linux/Windows)*

    KeyGenDistributed
       /lib
           /QryptSecurity
               /bin (Windows)
               /include
               /lib
               /res (Windows)

**MacOS**
1. Make sure there is a "Frameworks" directory in the local user's "Library" directory.  If not create one. 
1. Copy the QryptSecurity.framework directory and its contents to ~/Library/Frameworks/.

*Expected Folder structure (MacOS)*

    ~/Library/Frameworks
       /QryptSecurity.framework

## Build
To change to the KeyGenLocal folder:
    
    {{< commandline text="cd KeyGenLocal" >}}

To make a (debug) build:
    
    {{< commandline text="./build.sh --build_type=Debug" >}}

To find the build folder (if it built successfully):

*For linux/mac*
    
    {{< commandline text="ls -d build" >}}
    
*For windows*

    {{< commandline text="ls -d build/Debug/" >}}

To see more build options:
    
    {{< commandline text="./build.sh --help" >}}

## Run
To change to the KeyGenLocal build folder:

*For linux/mac*
    
    {{< commandline text="cd build" >}}

*For windows*

    {{< commandline text="cd build/Debug" >}}


To create and dspaly the locally generated AES key:

    {{< commandline text="./KeyGenLocal --token=${QRYPT_TOKEN} --cache-dir=cache" >}}
 
## Debug
If you open the folder KeyGenLocal In Visual Studio Code, you will find a debug setup for KeyGenLocal.

