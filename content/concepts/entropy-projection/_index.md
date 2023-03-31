+++
title = "Key Entropy Size"
date = 2021-10-23T15:01:22-04:00
weight = 50
chapter = false
+++

## Formula

{{< rawhtml >}}

<div class="code-like-snippet-example">
    <span class="green-text">Total entropy size</span> = 
    (<span class="orange-text">Number of keys</span>) x 
    (<span class="blue-text">Entropy size per key</span>)
</div>

{{< /rawhtml >}}

{{< rawhtml >}}

<table style="margin-bottom: 4rem">
    <tr>
        <th>Key Size (bytes)</th>
        <th><span class="blue-text">Entropy Size Per Key (bytes)</span></th>
    </tr>
    <tr>
        <td>16</td>
        <td><span class="blue-text">20</span></td>
    </tr>
    <tr>
        <td>32 (size of an AES-256 key)</td>
        <td><span class="blue-text">40</span></td>
    </tr>
    <tr>
        <td>64</td>
        <td><span class="blue-text">80</span></td>
    </tr>    
    <tr>
        <td>256</td>
        <td><span class="blue-text">290</span></td>
    </tr>    
    <tr>
        <td>1,024 (1 KiB)</td>
        <td><span class="blue-text">1,140 (1.11 KiB)</span></td>
    </tr>
    <tr>
        <td>10,240 (10 KiB)</td>
        <td><span class="blue-text">11,380 (11.11 KiB)</span></td>
    </tr>
    <tr>
        <td>102,400 (100 KiB)</td>
        <td><span class="blue-text">113,780 (111.11 KiB)</span></td>
    </tr>
    <tr>
        <td>1,048,576 (1 MiB)</td>
        <td><span class="blue-text">1,165,090 (1.11 MiB)</span></td>
    </tr>
    <tr>
        <td>10,485,760 (10 MiB)</td>
        <td><span class="blue-text">11,650,850 (11.1 MiB)</span></td>
    </tr>
</table>
{{< /rawhtml >}}

**Example 1:**

To generate (or to sync) 100 of AES-256 keys, the entropy size will be

{{< rawhtml >}}

<div class="code-like-snippet-example">
    <span class="orange-text">100 keys</span> x
    <span class="blue-text">40 bytes/key</span> =
    <span class="green-text">4,000 bytes</span> = 
    <span class="green-text">3.91 KiB</span>
</div>

{{< /rawhtml >}}

**Example 2:**

To generate (or to sync) 100 of 256-byte OTP keys, the entropy size will be

{{< rawhtml >}}

<div class="code-like-snippet-example">
    <span class="orange-text">100 keys</span> x
    <span class="blue-text">290 bytes/key</span> =
    <span class="green-text">29,000 bytes</span> = 
    <span class="green-text">28.32 KiB</span>
</div>

{{< /rawhtml >}}

**Example 3:**

To generate (or to sync) 100 of AES-256 keys and 200 of 256-byte OTP keys, the entropy size will be

{{< rawhtml >}}

<div class="code-like-snippet-example">
    (
        <span class="orange-text">100 keys</span>
        <span>x</span>
        <span class="blue-text">40 bytes/key</span>
    ) +
    (
        <span class="orange-text">200 keys</span>
        <span>x</span>
        <span class="blue-text">290 bytes/key</span>
    ) =
    <span class="green-text">62,000 bytes</span> = 
    <span class="green-text">60.55 KiB</span>
</div>

{{< /rawhtml >}}

**Example 4:**

An entropy quota of 25 MiB allows you to generate (or to sync)

{{< rawhtml >}}

<div class="code-like-snippet-example">
    (
        <span class="green-text">20 MiB</span>
        <span>/</span>
        <span class="blue-text">40 bytes/key</span>
    ) =
    (
        <span class="green-text">20,971,152 bytes</span>
        <span>/</span>
        <span class="blue-text">40 bytes/key</span>
    ) =
    <span class="orange-text">65,536 keys</span> 
    <span class="black-text">of 32-bytes</span> 
</div>

{{< /rawhtml >}}
