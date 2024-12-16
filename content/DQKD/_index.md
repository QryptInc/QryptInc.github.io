+++
menuTitle = "DQKD"
title = "Digital Quantum Key Distribution (DQKD)  "
date = 2021-12-14T11:01:08-04:00
weight = 2
disableToc = "true"
+++

## What is DQKD?

Alice is at one location (Site A), and Bob is at a different location (Site B). Each location has its own Key Management Entity (KME) that stores keys and makes them available for use by local clients.

Alice wants to generate a symmetric encryption key and store it in the KME at Site A. She also wants to share that key with Bob and store it in the KME at Site B. It should then be possible to retrieve the key from either site, using the same key id.

Traditional QKD systems use isolated fiber-optic or satellite based networks to send the key material between the sites.

Qrypt's DQKD solution uses Qrypt's [BLAST](https://www.qrypt.com/wp-content/uploads/2022/03/Whitepaper-EverlastingSecurity.pdf#page=9) protocol instead. The advantage of this protocol is that it makes it possible to exchange keys between sites securely over the public internet, without having to establish an isolated fiber-optic or satellite network.
## How it works:
A DQKD cluster consists of multiple sites, each of which has a KME that is identified by a unique KME ID.

Each site has a server exposes the same API, which is an instance of the [ETSI GS QKD 014](https://www.etsi.org/deliver/etsi_gs/QKD/001_099/014/01.01.01_60/gs_qkd014v010101p.pdf) specification.

The cluster is secured using a single certificate trust chain. All endpoints on the cluster enforce mutual TLS, so all clients will need a client cert that is part of the same trust chain to call the endpoints on the respective sites.

### Generating a key - example data flow
- Alice calls the enc_keys endpoint on Site A to generate a key that she wants to share with Bob:
```
 curl --cert My_Certs.p12 \
    "https://dqkd-eastus-1.qrypt.net/api/v1/keys/(Bob's KME ID)/enc_keys"
```
- The DQKD server uses the BLAST protocol to generate a key and a new random key ID, and stores the key in the local KME

- The key ID and metadata required to re-genrate that key is sent to site B.

- The DQKD server at site B receives the metadata and uses it to re-generate the key.

- The key is then stored and associated with the key ID in site B's KME.

- Alice receives the key material along with the key ID in the response to her original request:

```
{"keys": [{"key": "KEY_MATERIAL","key_ID": "SOME_KEY_ID"}]}
```

- Alice sends Bob the key ID.

- Bob calls the dec_keys endpoint on the DQKD server at site B to get a copy of the key:
```
 curl --cert My_Cert.p12 \
    "https://dqkd-westus-1.qrypt.net/api/v1/keys/(Alice's KME ID)/dec_keys" \
    -H "Content-Type: application/json" \
    -d '{"key_IDs": [{"key_ID": "SOME_KEY_ID"}]}'
```
- Bob receives the key material in the response:
```
{"keys": [{"key": "KEY_MATERIAL", "key_ID": "SOME_KEY_ID"}]} 
```


### Data flow - Illustrated
![FullPage](images/dqkddiagram.svg)
