+++
title = "Quickstart: Local Key Generation"
date = 2021-10-18T09:01:22-04:00
weight = 20
chapter = false
+++

## Sample Code

Find the finalized code for this quickstart on [GitHub](https://github.com/QryptInc/qrypt-security-quickstarts-cpp).

## Prerequisites
- A Qrypt Account. [Create an account for free](https://portal.qrypt.com/).
- Install [CMake](https://cmake.org/).
- (Windows) Install git bash - comes with typical git install.
- (Optional) Install [Visual Studio Code](https://code.visualstudio.com/).

# Setup
1. Clone the repo containing this quickstart to a local folder on a Linux, Mac or Windows platform.
1. Retrieve a token from the [Qrypt Portal](https://portal.qrypt.com/) with the scope **ENTROPY**.
1. (Optional) Create an environment variable **QRYPT_TOKEN** for it. For simplicity, the commands below will be referencing a **QRYPT_TOKEN** environment variable but you can also just use the token direclty in the commands below.
1. Download the Qrypt Security SDK for your platform.
1. Create a lib folder and extract the Qrypt Security SDK into it.

*Expected Folder structure*

    KeyGenLocal
       /lib
           /QryptSecurity
               /bin (Windows)
               /include
               /lib
               /res (Windows)

**Macos Security Warning**

Mac users will need to allow use of the library in the Security & Privacy settings. This will be fixed in a future release.

*Reference*

https://support.apple.com/en-us/HT202491
## Build
To change to the KeyGenLocal folder:
    
    vm@vm:~$ cd KeyGenLocal

To make a (debug) build:
    
    vm@vm:~/KeyGenLocal$ ./build.sh --build_type=Debug

To find the build folder (if it built successfully):

*For linux/mac*
        
    vm@vm:~/KeyGenLocal$ ls -d build
    
*For windows*

    vm@vm:~/KeyGenLocal$ ls -d build/Debug/

To see more build options:
    
    vm@vm:~/KeyGenLocal$ ./build.sh --help

## Run
To change to the KeyGenLocal build folder:

*For linux/mac*
    
    vm@vm:~$ cd KeyGenLocal/build

*for windows*

    vm@vm:~$ cd KeyGenLocal/build/Debug


To create and dspaly the locally generated AES key:

    ./KeyGenLocal --token=${QRYPT_TOKEN}
 
## Debug
If you open the folder KeyGenLocal In Visual Studio Code, you will find a debug setup for KeyGenLocal.

