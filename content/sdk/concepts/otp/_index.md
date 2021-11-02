+++
title = "One-Time Pad (OTP)"
date = 2021-10-23T15:01:22-04:00
weight = 10
chapter = false
+++

## Our Technology 

Qrypt offers solutions to make One-Time Pads, the only known information theoretically secure symmetric encryption algorithm, finally practical in industry. 

### What is classical cryptographic security? 

A cryptographic algorithm is considered secure, when the algorithm has been around for several years, and there is still no known method to “break” the algorithm with a classical computer. 

For example, the widely used RSA algorithm has been around since 1977 with no significant progress made on a method to break it with a classical computer. 

### What is post-quantum security? 

With the age of quantum computers being on the horizon, researchers have also explored methods to break cryptography using a quantum computer. Post-quantum cryptography means that after years of research, there is still no known method to “break” the cryptography, even given a quantum computer. 

For example, RSA, would not satisfy post-quantum security because Shor’s algorithm, an attack using a quantum computer, was discovered to break RSA in 1994. On the other hand, AES-256 is considered post-quantum because no quantum attacks have been discovered since its publication in 1998. 

{{< figure src="images/otp-intro.svg" title="One-Time Pads" >}}

A One-Time Pad cipher is when a randomly chosen key, the same length of the plaintext, is XORed with the plaintext to produce the ciphertext. If the key is truly chosen randomly, all plaintexts of the given size are equally likely to have produced the ciphertext.

### What is information theoretic security?
One-Time Pads have been mathematically proven to be information theoretically secure, meaning there is a mathematical proof that there exist no attacks (even with a computationally unbounded adversary) that can break a One-Time Pad. On the other hand, it is possible for a “post-quantum” algorithm to be broken, if in the future, someone were to discover a quantum attack on the algorithm.

### Why isn’t everyone using One-Time Pads?
One-Time Pads are only secure if the key is truly random, **and only recent quantum technology has made truly random keys possible**.

In addition, One-Time Pads are only secure if the keys are never reused. This means we need to share a newly randomly generated key, which is the same size of the plaintext, every time we want to send a new plaintext message. **This reduces the security of the One-Time Pad down to the security of the key exchange algorithm.**

## Qrypt Data at Rest Algorithm – QDARA
To encrypt data at rest, we don’t need to worry about key exchange. There will either be a single party encrypting data on their device, or multiple parties who have physically distributed a truly random string X. The use case for the QDARA client is described in Section 5.1 of the [whitepaper](https://cs.nyu.edu/~dodis/ps/blast.pdf).

### BLAST
The Bounded Linearly Accessible String (BLAST) extractor (Yevgeniy Dodis and Kevin Yeo, 2021) is a cryptographic primitive that offers a stateless solution for multiple parties to extract a One-Time Pad given a truly random string *X*.

Given a pool of truly random numbers *X*, BLAST takes a seed *S* as input, and outputs a One-Time Pad *R*. The extracted R is indistinguishable from a randomly generated *R*.

{{< figure src="images/otp-blast.svg" >}}

See the [whitepaper](https://cs.nyu.edu/~dodis/ps/blast.pdf) for more details about BLAST and a proof of its indistinguishability from random. Note that the whitepaper refers to BLAST as a doubly affine extractor.

### Encryption and Decryption
Each encryption has three inputs: a plaintext, a key, and either an initialization vector (IV) or a seed. Decryption requires a ciphertext, the same key, and the same IV or seed to decrypt. The procedures are described in more detail in the Init, Encrypt, and Decrypt methods below.

*Init (Encryptor):*
1. Obtain quantum random X from Qrypt and store in qrand files.
1. Generate a seed S_AES on your machine using OpenSSL.
1. Extract an AES-256 key and IV pair ¬K using BLAST with the seed S_AES and quantum random X and store them in the qcache file.
1. Physically transfer qrand files and the qcache file to the decryptor.

*Init (Decryptor)*
1. Physically obtain qrand files and qcache file from the encryptor.

Note: The user is responsible for storing the qrand and qcache files securely.

{{< figure src="images/otp-init.svg" >}}

*Encrypt*
{{< rawhtml >}}
<ol>
<li>Generate a seed <i>S<sub>OTP</sub></i> and an AES-256 key and IV pair <i>K<sub>0</sub></i> on your machine from OpenSSL.</li>
<li>Extract the One-Time Pad using the BLAST with the seed <i>S<sub>OTP</sub></i> and quantum random <i>X</i>.</li>
<li>Compute the ciphertext by XORing the One-Time Pad with the plaintext.</li>
<li>Encrypt the ciphertext once more with AES-256 OCB mode to provide authentication with the seed <i>S<sub>OTP</sub></i> as associated data.</li>
<li>Encrypt <i>S<sub>OTP</sub></i> and <i>K<sub>0</sub></i> using AES-256 OCB mode with the key and IV pair <i>K</i> in your cache file and append it to the final ciphertext.</li>
</ol>
{{< /rawhtml >}}

{{< figure src="images/otp-encrypt.svg" >}}

*Decrypt*
{{< rawhtml >}}
<ol>
<li>Decrypt the seed <i>S<sub>OTP</sub></i> and AES-256 key and IV pair <i>K<sub>0</sub></i> using AES-256 OCB mode with the key and IV pair <i>K</i> in your cache file.</li>
<li>Decrypt the ciphertext using AES-256 OCB mode with the key and IV pair <i>K</i> in your cache file.</li>
<li>Extract the One-Time Pad using BLAST with the seed <i>S<sub>OTP</sub></i> and quantum random <i>X</i>.</li>
<li>Compute the final plaintext by XORing the One-Time Pad with the ciphertext.</li>
</ol>
{{< /rawhtml >}}

{{< figure src="images/otp-decrypt.svg" >}}

### Why use BLAST instead of using *X* directly?
Having a stateless method of determining the One-Time pad from *X* makes it much easier for parties of 3 or more to communicate using the same random pool *X*. Instead of requiring all parties to keep track of an index which can easily get out of sync, it is much simpler to use a new seed for each encryption. Using BLAST also ensures that the One-Time Pad is never stored in the clear and offers additional security in case chunks of *X* are stolen.

### Are we reusing One-Time Pads?
We keep track of the percentage of X we have used in the cache file. Once the usage exceeds a user-configurable percentage (default set to 50%) of *X*, the user can no longer encrypt with *X* unless they use the –force flag. The percentage corresponds to 1-β in the [whitepaper](https://cs.nyu.edu/~dodis/ps/blast.pdf).

Although it is possible that BLAST uses the same bit twice in different encryptions, the [whitepaper](https://cs.nyu.edu/~dodis/ps/blast.pdf) proves that the extracted One-Time Pad is indistinguishable from a purely random One-Time Pad as long as the total length of the One-Time Pads used is bounded by (1-β)|X|.

### Where are the seeds stored?
The seeds are encrypted with AES-256, and the encrypted seed is appended to the ciphertext. The AES key and IV are stored in the cache file.

### What level of security does QDARA offer?
Our QDARA client offers post-quantum security. An adversary can only gain secret information if they have access to both the full random string *X* (by breaking TLS when the user downloads *X*) and the seed *S* (by breaking AES). Since AES is a post-quantum algorithm, the client achieves post-quantum security.

### Does QDARA provide authentication?
Yes, after the ciphertext is encrypted with the One-Time Pad, we use AES-256 OCB mode to provide authentication with the seed as associated data. If the ciphertext is tampered with, the AEAD authentication will fail.

### How much random do I need for an encryption?
This depends on the user-configurable percentage α (default set to 50%), which is the maximum amount of random you can use from a cache. There are three constraints you must fulfill to encrypt a file of size *m*:

{{< rawhtml >}}
<ol>
<li>You must have at least m bytes available to use out of the α|X| total available bytes.</li>
<li>If you wish to encrypt a file of size <i>m</i>, your cache must have a total of at least
<img src="images/otp-equation-how-much-random.svg"/>
bytes in order to sample the necessary size using BLAST *see whitepaper for details, note we set ϵ=2<sup>-64</sup>). Note that this refers to the total number of random bytes and is independent of the number of available random bytes.</li>
<li>Regardless of <i>m</i>, you must have at least enough random to call the BLAST extractor to generate an AES key and IV (44 bytes). You can obtain this value by plugging in m=44 to the above equation.</li>
</ol>
{{< /rawhtml >}}

For example, to encrypt a file of 5 KB = 5120 bytes, with our depletion parameter set to α=0.5, we must:
1. Have at least 5120 random bytes available. 
1. Have at least 14,890 total random bytes (obtained from plugging in *m = 5120* into the equation).
1. Since we are encrypting more than 44 bytes, this requirement is redundant.

Here is a table of minimum cache sizes for reference.

| Plaintext Size | Minimum Cache Size |
|---|---|
| 1 KB | 5 KB |
| 10 KB	| 27 KB |
| 100 KB | 218 KB |
| 1 MB | 2103 KB (> 2 MB) |
| 2 MB | 4173 KB (> 4 MB) |
| 4 MB | 8301 KB (> 8 MB) |

### How long does it take to encrypt?
For a random pool size of 10 MB, we have the following performance numbers which were collected on a MacBook (15-inch Mid 2015).
 
| Plaintext Size | Time (seconds) |
|---|---|
| 1 KB | 0.06 |
| 10 KB	| 0.25 |
| 100 KB | 5.80 |
| 1 MB | 203.12 |
| 2 MB | 600.56 |
| 4 MB | 1673.12 |

## Qrypt Key Exchange Solution – BLAST

Qrypt offers a novel key exchange solution, (Section 5.2 of the whitepaper) which offers everlasting security.

### How secure are key exchange algorithms?

{{< rawhtml >}}
<table>
    <tr>
        <th>Algorithms</th>
        <th>Level of Security</th>
        <th>Drawbacks</th>
    </tr>
    <tr>
        <td>RSA, Diffie Hellman, ECDH</td>
        <td>Classical security</td>
        <td>
            <ul>
                <li>Not post-quantum</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Classic McEliece, CRYSTALS-KYBER, FrodoKEM</td>
        <td>Post-quantum security</td>
        <td>
            <ul>
                <li>Not provably secure</li>
                <li>Slow/inefficient</li>
    </tr>
    <tr>
        <td>Quantum Key Distribution (QKD): BB84, E91, B92</td>
        <td>Information theoretically secure (dependent on accuracy of hardware)</td>
        <td>
            <ul>
                <li>Costly</li>
                <li>Range of communication is limited</li>
                <li>Tolerance for error in cryptographic security, however, is many order of magnitude smaller than in most physical engineering scenarios making it very difficult to validate</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td><b>Qrypt solution</b></td>
        <td>Everlasting security (explained below)</td>
        <td>
            <ul>
                <li>Assumes the user has a secure channel with a user-configurable value <i>g</i> out of <i>t</i> Qrypt servers</li>
            </ul>
        </td>
    </tr>
</table>
{{< /rawhtml >}}

### What is everlasting security?
A protocol which achieves everlasting security guarantees that an encryption is information theoretically secure, given that the initial key exchange of the seed *S* is not broken within a time *T* which we can choose (i.e. a week). This means that a week after the two parties exchange an initial seed *S*, even a computationally unbounded adversary (with access to both classical and quantum computers) cannot break the encryption.

## Levels of Security

1.	Classical security that is vulnerable to quantum computers (i.e. RSA, ECDH)

2.	Post quantum security that has no known algorithm that quantum computers could run to break (i.e. FrodoKEM, Crystals-Kyber)

For levels 1 and 2, to break the encryption, an adversary would need to:
- Harvest data between Alice and Bob
- Break the key exchange
 
{{< figure src="images/otp-levels-of-security-levels1and2.svg" >}}

3a)  Everlasting security which is provably secure against an unbounded adversary after phase 1 (while the server is still accepting decryption requests), where:
- the seed key exchange has level 1 security in phase 1
- we assume g out of T servers have secure, authenticated channels with the client (where these channels use TLS)

3b)  Everlasting security which is provably secure against an unbounded adversary after phase 1 (while the server is still accepting decryption requests), where:
- the seed key exchange has level 2 security in phase 1
- we assume g out of T servers have secure, authenticated channels with the client (where these channels use TLS)

3c) Everlasting security which is provably secure against an unbounded adversary after phase 1 (while the server is still accepting decryption requests), where:
-	the seed has level 2 security in phase 1
-	we assume g out of T servers have secure, authenticated channels with the client (where these channels use post-quantum TLS)

{{< figure src="images/otp-levels-of-security-level3.svg" >}}
 
For levels 3a, 3b, and 3c, to break the encryption, an adversary would need to:
- Harvest data between Alice and Bob
- Harvest data from greater than T-g server links to Alice or Bob
- Break the key exchange of the seed
- Break the protocol for downloading random

4. Information theoretic security that is provably secure against an unbounded adversary (which Qrypt only has the capability of doing with physical transfer of key material)

### What levels of security does Qrypt offer?

Our SDK offers:
1. Classical SKU for QDEA at level 1
2. Post-quantum SKU for QDEA, QDARA at level 2
3. Digital QKD (everlasting security SKU) at levels 3a and 3b
Note that for an adversary to break a SKU, they must break the protocol or primitive in all 3 columns below.

{{< rawhtml >}}
<table>
    <tr>
        <th>Level</th>
        <th>Qrypt offering</th>
        <th>Data Harvesting</th>
        <th>Key exchange for seeds/symmetric keys</th>
        <th>Protocol for downloading random</th>
    </tr>
    <tr>
        <td>Level 1 (classical)</td>
        <td>QDEA classical SKU</td>
        <td>Adversary needs to harvest data from only one network transmission</td>
        <td>ECDH (classical)</td>
        <td>N/A</td>
    </tr>
    <tr>
        <td>Level 2 (post-quantum)</td>
        <td>QDARA, QDEA post-quantum sku</td>
        <td>Adversary needs to harvest data from only one network transmission</td>
        <td>Lattice crypto (PQC)</td>
        <td>N/A</td>
    </tr>
    <tr>
        <td>Level 3a (everlasting security)</td>
        <td>Digital QKD with user-supplied channel</td>
        <td>Adversary needs to harvest data from:
            <ul>
                <li>More than T-g transmissions from QDEA servers</li>
                <li>Key exchange of seed</li>
            </ul>
        </td>
        <td>ECDH (classical)</td>
        <td>Classical TLS</td>
    </tr>
    <tr>
        <td>Level 3b (everlasting security)</td>
        <td>Digital QKD sample</td>
        <td>Adversary needs to harvest data from:
            <ul>
                <li>More than T-g transmissions from QDEA servers</li>
                <li>Key exchange of seed</li>
            </ul>
        </td>
        <td>Lattice crypto (PQC)</td>
        <td>Classical TLS</td>
    </tr>
    <tr>
        <td>Level 3c (everlasting security)</td>
        <td>--</td>
        <td>Adversary needs to harvest data from:
            <ul>
                <li>More than T-g transmissions from QDEA servers</li>
                <li>Key exchange of seed</li>
            </ul>
        </td>
        <td>Lattice crypto (PQC)</td>
        <td>Post-quantum TLS</td>
    </tr>
    <tr>
        <td>Level 4 (information theoretic security)</td>
        <td>--</td>
        <td>Adversary needs to steal physical devices</td>
        <td>Physical transfer</td>
        <td>N/A</td>
    </tr>
</table>
{{< /rawhtml >}}









