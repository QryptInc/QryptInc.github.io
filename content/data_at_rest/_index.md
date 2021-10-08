+++
title = "Data at rest"
date = 2021-10-07T11:15:52-04:00
weight = 5
disableToc = "true"
+++

## Getting Started with the Data at Rest Client
In the following guide, we will help you get started with encrypting your data with a One Time Pad using the Qrypt Data at Rest Algorithm (QDARA) client. This guide will show you how to encrypt a file containing the message “Hello World”. For more detailed instruction on using the command line interface, please reference our [QDARA Reference Guide](https://www.qrypt.com/qdara-ref-guide). 

For decryption, there are two use cases: 

1. A user can encrypt and decrypt files on a single device. 

2. Alice physically transfers her quantum random and cache file to Bob. Alice encrypts data and sends it to Bob over the internet, and Bob decrypts. 

##### Before you get started

Follow the instructions at https://www.qrypt.com/docs/eaas to 

1. Create a free Qrypt account 

2. Generate an access token. 

Download the QDARA client for the OS you are running at https://portal.qrypt.com/ into a folder of your choice. To verify you downloaded the correct .zip file, you can check that the SHA256 Hash matches the one listed on the Download page.

For MacOS and Linux, to compute the hash, run

> `shasum -a 256 qdaracl-<version-os>.zip`

Note that to verify the zip file for MacOS, you must choose to “Save file” because MacOS will automatically extract the file if you choose to open it.

For Windows, to compute the hash, run

<code>certUtil -hashfile qdaracl-<version-os>.zip SHA256</code>

#### (Optional) Add installation folder to your PATH environment variable 

For MacOS and Linux, edit your .bashrc or .zshrc file and add the line 

> `export PATH=$PATH:<insert installation folder path here>`

For Windows, open the start menu and search for “Edit environment variables”. Click on the “Path” variable and click “edit.” Add a new path for the folder containing the QDARA client. 

 Close your terminal, and test that you can run the tool by running 

> `qdaracl -h`

#### Download Quantum Random for your Key 

You will need your access token generated from the Qrypt portal. To download 2 KB of random, run 

> `qdaracl download -t <insert token here> -s 2 -o key.qrand`

This will store 2 KB of quantum random into key.qrand. Note that you need at least as much random as the size of your plaintext file, and a minimum of 2 KB of random to encrypt any file. 

#### Initiate the client encryption tool 

> `qdaracl init -i key.qrand -o my_cache.qcache` 

This will generate a cache file that stores metadata about how much of the random has been used. Note that it is the user’s responsibility to store the cache file securely. 

 
### Encrypt your data 

Create a plaintext file. 

> `echo "Hello World" > plaintext.txt`

 
Encrypt the file. 

> `qdaracl encrypt -c my_cache.qcache -i plaintext.txt -o ciphertext.qdara` 

 
### Decrypt your data 

When you are ready to decrypt, you can simply run 

> `qdaracl decrypt -c my_cache.qcache -i ciphertext.qdara -o new_plaintext.txt` 

Note that if you are a user on a different device, you must physically obtain my_cache.qcache and key.qrand from the original encryptor. 

 

#### Encrypt more files 

To encrypt larger size files, you may need to download more random! Here is a table of the minimum amount of random you need for a given plaintext size. 
| Plaintext Size |	Minimum Random Size in Cache |
| ------ | ------ |
| 1 KB | 5 KB |
| 10 KB | 27 KB |
| 100 KB | 218 KB |
| 1 MB | 2103 KB (> 2 MB) |
| 2 MB | 4173 KB (> 4 MB) |
| 4 MB | 8301 KB (>8 MB) |