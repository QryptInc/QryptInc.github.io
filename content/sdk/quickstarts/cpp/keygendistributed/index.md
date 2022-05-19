+++
title = "Quickstart: Distributed Key Generation"
date = 2021-10-18T09:01:22-04:00
weight = 20
chapter = false
+++

## Sample Code

Find the finalized code for this quickstart on {{< externalLink link="https://github.com/QryptInc/qrypt-security-quickstarts-cpp" text="GitHub" >}}.

## Prerequisites
- A Qrypt Account. {{< externalLink link="https://portal.qrypt.com/register" text="Create an account for free" >}}.
- Install {{< externalLink link="https://cmake.org/" text="CMake" >}}.
- (Windows) Install git bash - comes with typical git install.
- (Optional) Install {{< externalLink link="https://code.visualstudio.com/" text="Visual Studio Code" >}}.

## Setup
1. Clone the repo containing this quickstart to a local folder on a Linux, Mac or Windows platform.
1. Retrieve a token from the {{< externalLink link="https://portal.qrypt.com/tokens" text="Qrypt Portal" >}}.

1. (Optional) Create an environment variable **QRYPT_TOKEN** for it. For simplicity, the commands below will be referencing a **QRYPT_TOKEN** environment variable but you can also just use the token directly in the commands below.
1. Download the Qrypt Security SDK from the {{< externalLink link="https://portal.qrypt.com/downloads/sdk-downloads" text="Qrypt Portal" >}} for your platform.
1. Create a lib folder and extract the Qrypt Security SDK into it.

*Expected Folder structure*

    KeyGenDistributed
       /lib
           /QryptSecurity
               /bin (Windows)
               /include
               /lib
               /res (Windows)

{{% notice warning %}}
The Qrypt Security Linux SDK v0.5.1 is compatible with CentOS 7 only. The next release will migrate compatibility to modern versions of Fedora and Ubuntu.
{{% /notice %}}

## Build
To change to the KeyGenDistributed folder:
    
    {{< commandline text="cd KeyGenDistributed" >}}

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
### Run as Alice
To change to the KeyGenDistributed build folder:

*For linux/mac*
    
    {{< commandline text="cd KeyGenDistributed/build" >}}

*for windows*

    {{< commandline text="cd KeyGenDistributed/build/Debug" >}}

 
To run as Alice:

    {{< commandline text="./KeyGenDistributed --user=alice --token=${QRYPT_TOKEN} --key-type=aes --metadata-filename=metadata.bin" >}}
 
### Run as Bob
To change to the KeyGenDistributed build folder:

*For linux/mac*
    
    {{< commandline text="cd build" >}}

*for windows*

    {{< commandline text="cd build/Debug" >}}

 
To run as Alice:

    {{< commandline text="./KeyGenDistributed --user=bob --token=${QRYPT_TOKEN} --metadata-filename=metadata.bin" >}}

## Debug
If you open the folder KeyGenDistributed In Visual Studio Code, you will find debug setups for running as Alice and Bob.


