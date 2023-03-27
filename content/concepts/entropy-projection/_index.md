+++
title = "Key Entropy Size"
date = 2021-10-23T15:01:22-04:00
weight = 50
chapter = false
+++

## Formula

{{< rawhtml >}}

<div class="code-like-snippet-example">
    <span class="blue-text">Total entropy size</span> = 
    (<span class="orange-text">Number of keys</span>) x 
    (<span class="orange-text">Entropy size per key</span>)
</div>

{{< /rawhtml >}}

{{< rawhtml >}}

<table style="margin-bottom: 4rem">
    <tr>
        <th>Key Size (byte)</th>
        <th>Entropy Size Per Key (byte)</th>
    </tr>
    <tr>
        <td>16</td>
        <td>1,600 (1.56 KiB)</td>
    </tr>
    <tr>
        <td>32 (size of an AES-256 key)</td>
        <td>1,680 (1.64 KiB)</td>
    </tr>
    <tr>
        <td>64</td>
        <td>1,760 (1.72 KiB)</td>
    </tr>    
    <tr>
        <td>256</td>
        <td>2,480 (2.42 KiB)</td>
    </tr>    
    <tr>
        <td>1,024 (1 KiB)</td>
        <td>4,800 (4.69 KiB)</td>
    </tr>
    <tr>
        <td>10,240 (10 KiB)</td>
        <td>27,920 (27.27 KiB)</td>
    </tr>
    <tr>
        <td>102,400 (100 KiB)</td>
        <td>234,000 (228.52 KiB)</td>
    </tr>
    <tr>
        <td>1,048,576 (1 MiB)</td>
        <td>2,264,640 (2.16 MiB)</td>
    </tr>
    <tr>
        <td>10,485,760 (10 MiB)</td>
        <td>22,646,400 (21.6 MiB)</td>
    </tr>
</table>
{{< /rawhtml >}}

**Example 1:**

To generate (or to sync) 100 of AES-256 keys, the entropy size will be

{{< rawhtml >}}

<div class="code-like-snippet-example">
    <span class="blue-text">100</span> x
    <span class="orange-text">22,440</span> =
    <span class="blue-text">2,244,000 bytes</span> = 
    <span class="blue-text">2.1 MiB</span>
</div>

{{< /rawhtml >}}

**Example 2:**

To generate (or to sync) 100 of 256-byte OTP keys, the entropy size will be

{{< rawhtml >}}

<div class="code-like-snippet-example">
    <span class="blue-text">100</span> x
    <span class="orange-text">24,280</span> =
    <span class="blue-text">2,428,000 bytes</span> = 
    <span class="blue-text">2.3 MiB</span>
</div>

{{< /rawhtml >}}

**Example 3:**

To generate (or to sync) 100 of AES-256 keys and 200 of 256-byte OTP keys, the entropy size will be

{{< rawhtml >}}

<div class="code-like-snippet-example">
    (
        <span class="blue-text">100</span>
        <span>x</span>
        <span class="blue-text">22,440</span>
    ) x
    (
        <span class="orange-text">200</span>
        <span>x</span>
        <span class="orange-text">24,280</span>
    ) =
    <span class="blue-text">7,100,000 bytes</span> = 
    <span class="blue-text">6.8 MiB</span>
</div>

{{< /rawhtml >}}

**Example 4:**

25 MiB entropy quota allows you to generate (or to sync)

{{< rawhtml >}}

<div class="code-like-snippet-example">
    (
        <span class="orange-text">25</span>
        <span>*</span>
        <span class="orange-text">1024</span>
        <span>*</span>
        <span class="orange-text">1024</span>
        <span>/</span>
        <span class="orange-text">22,440</span>
    ) x
    (
        <span class="orange-text">200</span>
        <span>x</span>
        <span class="orange-text">24,280</span>
    ) =
    <span class="blue-text">1168 of AES-256 keys in total</span> 
</div>

{{< /rawhtml >}}
