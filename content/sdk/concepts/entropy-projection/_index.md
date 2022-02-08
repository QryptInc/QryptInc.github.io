+++
title = "How to estimate the projected size of entropy?"
date = 2021-10-23T15:01:22-04:00
weight = 50
chapter = false
+++

#### Formula:

**Total entropy size = (Number of keys) x (Entropy size per key)**

#### Table:
{{< rawhtml >}}

<table>
    <tr>
        <th>Key Size (byte)</th>
        <th>Entropy Size Per Key (byte)</th>
    </tr>
    <tr>
        <td>16</td>
        <td>22,120 (21.6 KiB)</td>
    </tr>
    <tr>
        <td>32 (size of an AES-256 key)</td>
        <td>22,440 (21.9 KiB)</td>
    </tr>
    <tr>
        <td>64</td>
        <td>23,080 (22.5 KiB)</td>
    </tr>    
    <tr>
        <td>128</td>
        <td>24,280 (23.7 KiB)</td>
    </tr>
    <tr>
        <td>256</td>
        <td>26,680 (26.1 KiB)</td>
    </tr>    
    <tr>
        <td>512</td>
        <td>31,200 (30.5 KiB)</td>
    </tr>
    <tr>
        <td>1,024 (1 KiB) (1.0 KB)</td>
        <td>39,600 (38.7 KiB)</td>
    </tr>
    <tr>
        <td>2,048 (2 KiB) (2.0 KB)</td>
        <td>55,080 (53.8 KiB)</td>
    </tr>
    <tr>
        <td>4,096 (4 KiB) (4.1 KB)</td>
        <td>83,560 (81.6 KiB)</td>
    </tr>
    <tr>
        <td>32,768 (32 KiB) (32.8 KB)</td>
        <td>423,480 (413.6 KiB)</td>
    </tr>
</table>
{{< /rawhtml >}}



#### Example 1:

To generate (or to sync) 100 of AES-256 keys, the entropy size will be

100 x 22,440 = 2,244,000 bytes = 2.1 MiB.

#### Example 2:

To generate (or to sync) 100 of 128-byte OTP keys, the entropy size will be

100 x 24,280 = 2,428,000 bytes = 2.3 MiB.

#### Example 3:

To generate (or to sync) 100 of AES-256 keys and 200 of 128-byte OTP keys, the entropy size will be

100 x 22,440 + 200 x 24,280 = 7,100,000 bytes = 6.8 MiB.

#### Example 4:

25 MiB entropy quota allows you to generate (or to sync) 

25 * 1024 * 1024 / 22,440 = 1168 of AES-256 keys in total.