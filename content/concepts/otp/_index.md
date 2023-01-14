+++
title = "One-Time Pad (OTP)"
date = 2021-10-23T15:01:22-04:00
weight = 50
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

## BLAST Distributed

Qrypt offers a novel key generation solution, which offers everlasting security.

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
A protocol which achieves everlasting security guarantees that an encryption is information theoretically secure, given that the initial key exchange of the seed *S* is not broken within a time *T* which we can choose (i.e. an hour). This means that an hour after the two parties exchange an initial seed *S*, even a computationally unbounded adversary (with access to both classical and quantum computers) cannot break the encryption.

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






