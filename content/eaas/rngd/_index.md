+++
menuTitle = "RNG Tools"
title = "RNG Tools"
date = 2021-10-07T11:14:08-04:00
weight = 1
disableToc = "true"
+++

## Using Qrypt's Quantum Entropy in RNG Tools

*rng-tools* is a utility that allows you to inject entropy from hardware sources, prngs, and http streams into system devices. Qrypt's Quantum Entropy service is a random source option in *rng-tools*, allowing you to inject quantum entropy into system devices such as */dev/random*, */dev/urandom*, and user-defined nodes or files.

---

## Getting Started

To start using Qrypt's Quantum Entropy service in *rng-tools*, you need to create a Qrypt account, obtain an access token, and configure RNGD.

## Create a free Qrypt account

To request entropy, you must first create an account.

1.  Navigate to {{< externalLink link="https://portal.qrypt.com" text="https://portal.qrypt.com" >}} and create a new account.
2.  Enter your email address and a strong password, then click the button to create your account.
3.  Check your email for the 4-digit account confirmation code and enter it on the website to confirm your account.
4.  When prompted, enter your first and last name.

## Generate an access token

An access token is required to access entropy through Qrypt's Quantum Entropy service.

1. Navigate to the Tokens page.
2. Assign a name to the token to help you distinguish between different tokens.
3. Select the expiration period. This determines when the token will expire and need to be replaced.
4. Click the **"Generate token"** button.
5. The generated token will be displayed along with an example of how entropy data can be requested. Copy the token using the “Copy” button and store it in a secure location. Important: This is the only time you will be able to view the access token. Be sure to copy and store it before closing this popup.
6. Save the access token to a secure location. Because your access token is used to make requests for entropy—a budgeted resource—it should be treated as secure data, very much like a password.

---

## Installation

To use Qrypt's Quantum Entropy service in *rng-tools*, *rng-tools* must be installed and configured.

Clone the latest *rng-tools* master from GitHub.
```bash
git clone https://github.com/nhorman/rng-tools
```

Install rng-tools dependencies. Additional packages may be required, depending on linux distro. The configure script below will name any missing packages it encounters.
```bash
sudo apt install \
    make \
    libtool \
    libxml2-dev \
    libssl-dev \
    libcurl3-dev \
    libp11-dev \
    librtlsdr-dev \
    libusb-1.0-0-dev \
    libjansson-dev \
    libcap-dev
```

```bash
./autogen.sh
```

Add `--disable-dependency-tracking` if needed.
```bash
./configure
```

```bash
make
```

```bash
sudo make install
```

Verify installation.
```bash
which rngd
```

## Command Line Usage
The resulting *rngd* executable can run directly to start either a daemon or a foreground process. By default, *rngd* will run as a background daemon and attempt to use the "hwrng", "errand", "pkcs11", and "rtlsdr" random sources.

To run *rngd* using exclusively Qrypt's Quantum Entropy, run the following command. This will run *rngd* as a foreground process with the Qrypt source enabled and all other entropy sources disabled. rngd will send its random to the /dev/random device.
```
sudo rngd -f -x hwrng -x rdrand -x pkcs11 -x rtlsdr -n qrypt -O qrypt:tokenfile:<qrypt token path>
```

Command line options:
{{< rngd/rngd-options >}}

## Service Usage
*rng-tools* comes with a 'rngd.service' file for setting up a systemd service. To configure rngd to automatically start the Qrypt source on boot, follow these steps:

Save your Qrypt api token to a system-accessible directory, such as "/etc/rngd/qrypt.token". Then, edit rngd.service to add Qrypt arguments and options.
```
[Unit]
Description=Hardware RNG Entropy Gatherer Daemon
ConditionVirtualization=!container

# The "-f" option is required for the systemd service rngd to work with Type=simple
[Service]
Type=simple
ExecStart=<rngd install path> -f -x hwrng -x rdrand -x pkcs11 -x rtlsdr -n qrypt -O qrypt:tokenfile:<qrypt token path>
SuccessExitStatus=66

[Install]
WantedBy=multi-user.target
```

Copy the rngd service to systemd.
```
sudo cp rngd.service /etc/systemd/system/rngd.service
sudo chmod 644 /etc/systemd/system/rngd.service
```

Start the rngd service.
```
sudo systemctl daemon-reload
sudo systemctl start rngd
```

Verify the rngd service is running properly.
```
sudo systemctl status rngd
```

Enable the rngd service for it to start on system boot.
```
sudo systemctl enable rngd
```
