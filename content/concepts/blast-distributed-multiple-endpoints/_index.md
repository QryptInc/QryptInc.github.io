+++
title = "BLAST Distributed-multiple endpoints"
date = 2021-10-23T15:01:22-04:00
weight = 20
chapter = false
+++

Key distribution based on asymmetric algorithms is a weak link for cryptography.

Qrypt is the only company that enables encryption without distributing encryption keys – also basing them on trusted quantum random numbers.

1. The BLAST architecture enables generation of identical keys at multiple endpoints, so they are never distributed.
2. Caches of random allow for sampling by multiple clients – with time and usage controls that trigger cache shredding.
3. Client locally extracts keys from returned random – not even Qrypt can determine the keys.
4. No dedicated channels or infrastructure required – unlike quantum key distribution (QKD).

{{< figure src="images/blast.svg" >}}

---

**Walk-through**

1. Client A determines the key generation requirements: BLAST servers to be used, the sampling seeds, and extraction parameters​
2. Clients share the key generation requirements – seeds, extraction parameters​.
3. Each client independently samples BLAST APIs, assembling identical blocks of random on each client.​
4. Clients locally extracts keys - resulting in identical encryption keys which were never distributed​.

---

**Attack scenarios required to compromise keys are extreme**

1. Attacker compromises the A to B channel and decrypts the key generation requirements before the server caches are shredded and can no longer be sampled. Even with a quantum computer the time to decrypt is too long
2. Attacker compromises ALL aspects of the BLAST protocol, including TLS crypto​
   - Compromises ALL channels between a client and the N BLAST servers​
   - Compromises the A to B channel
   - Defeat TLS cryptography used in A to B channel
3. Full control of Client A or Client B

{{< figure src="images/blast_2.svg" >}}
