+++
title = "Distributed Key Generation"
date = 2021-10-18T09:09:06-04:00
weight = 10
+++

## Sample Code

Find the finalized code for these quickstarts on {{< externalLink link="https://github.com/QryptInc/qrypt-security-quickstarts-cpp" text="GitHub" >}}.

---

## Prerequisites

1. A Qrypt Account. {{< externalLink link="https://portal.qrypt.com" text="Create an account for free" >}}.
2. Install {{< externalLink link="https://cmake.org/install/" text="CMake" >}}.
3. (Windows) Install git bash - comes with typical git install.
4. (Optional) Install {{< externalLink link="https://code.visualstudio.com/" text="Visual Studio Code" >}}.

---

## Setup

1. Clone the repo containing this quickstart to a local folder on a Linux, Mac or Windows platform.
2. Install {{< externalLink link="https://cmake.org/install/" text="CMake" >}}.
3. (Optional) Create an environment variable QRYPT_TOKEN for it. For simplicity, the commands below will be referencing a QRYPT_TOKEN environment variable but you can also just use the token directly in the commands below.
4. Download the Qrypt Security SDK from the {{< externalLink link="https://portal.qrypt.com" text="Qrypt Portal" >}} for your platform.

### Linux/Windows

1. Verify the lib folder exists and extract the Qrypt Security SDK into it.

```
KeyGenDistributed
   /lib
       /QryptSecurity
           /bin (Windows)
           /include
           /lib
           /res (Windows)
```

### MacOS

1. Make sure there is a “Frameworks” directory in the local user’s “Library” directory. If not create one.
2. Copy the QryptSecurity.framework directory and its contents to ~/Library/Frameworks/.

Expected Folder structure (MacOS):

```less
~/Library/Frameworks
   /QryptSecurity.framework
```

---

## Build

To change to the KeyGenDistributed folder:

```text
cd KeyGenDistributed
```

To make a (debug) build:

```text
./build.sh --build_type=Debug
```

### Linux/MacOS

```text
ls -d build
```

### Windows

```text
ls -d build/Debug/
```

To see more build options:

```text
./build.sh --help
```

---

## Run

### Run as Alice

To change to the KeyGenDistributed build folder:

### Linux/MacOS

```text
cd KeyGenDistributed/build
```

### Windows

```text
cd KeyGenDistributed/build/Debug
```

### To run as Alice

```text
./KeyGenDistributed --user=alice --token=${QRYPT_TOKEN} --key-type=aes --metadata-filename=metadata.bin
```

---

## Run

### Run as Bob

To change to the KeyGenDistributed build folder:

### Linux/MacOS

```text
cd build
```

### Window

```text
cd build/Debug
```

### To run as Bob

```text
./KeyGenDistributed --user=bob --token=${QRYPT_TOKEN} --metadata-filename=metadata.bin
```

---

## Debug

If you open the folder KeyGenDistributed In Visual Studio Code, you will find debug setups for running as Alice and Bob.
