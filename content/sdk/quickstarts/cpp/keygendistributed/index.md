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
- (Optional) Install {{< externalLink link="https://code.visualstudio.com/" text="Visual Studio Code" >}}.

## Setup
1. Clone the {{< externalLink link="https://github.com/QryptInc/qrypt-security-quickstarts-cpp" text="repo" >}} containing this quickstart to a local folder.
1. Retrieve a token from the {{< externalLink link="https://portal.qrypt.com/tokens" text="Qrypt Portal" >}}.

1. (Optional) Create an environment variable **QRYPT_TOKEN** for it. For simplicity, the commands below will be referencing a **QRYPT_TOKEN** environment variable but you can also just use the token directly in the commands below.
1. Download the Qrypt Security SDK from the {{< externalLink link="https://portal.qrypt.com/downloads/sdk-downloads" text="Qrypt Portal" >}} for your platform.

1. Extract the Qrypt SDK.

    {{< commandline text="tar -zxvf qrypt-security-x.x.x-ubuntu.tgz" >}}

1. Copy the Qrypt SDK into the /qrypt-security-quickstarts-cpp/KeyGenDistributed/lib/QryptSecurity folder.

    {{< commandline text="cp -r qrypt-security-x.x.x-ubuntu/* /qrypt-security-quickstarts-cpp/KeyGenDistributed/lib/QryptSecurity" >}}

*Expected Folder structure*

    KeyGenDistributed
       /lib
           /QryptSecurity
               /include
               /lib

## Build
To change to the KeyGenDistributed folder:
    
    {{< commandline text="cd KeyGenDistributed" >}}

To make a (debug) build:
    
    {{< commandline text="./build.sh --build_type=Debug" >}}

To find the build folder (if it built successfully):
       
    {{< commandline text="ls -d build" >}}
    
To see more build options:
    
    {{< commandline text="./build.sh --help" >}}

## Run
### Run as Alice
To change to the KeyGenDistributed build folder:

    {{< commandline text="cd KeyGenDistributed/build" >}}

To run as Alice:

    {{< commandline text="./KeyGenDistributed --user=alice --token=${QRYPT_TOKEN} --key-type=aes --metadata-filename=metadata.bin" >}}
 
### Run as Bob
To change to the KeyGenDistributed build folder:

    {{< commandline text="cd build" >}}

To run as Bob:

    {{< commandline text="./KeyGenDistributed --user=bob --token=${QRYPT_TOKEN} --metadata-filename=metadata.bin" >}}

## Debug
If you open the folder KeyGenDistributed In Visual Studio Code, you will find debug setups for running as Alice and Bob.


