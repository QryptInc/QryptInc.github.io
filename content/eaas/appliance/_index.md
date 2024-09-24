+++
menuTitle = "On-Prem Appliance"
date = 2024-09-23T19:11:17-04:00
weight = 1
disableToc = "false"
+++

# Introduction

The Quantum Entropy Appliance (QEA) is a server that comes equipped with Qrypt’s quantum random number generator cards. These cards continuously measure quantum phenomena to generate streams of truly random bytes.

The QEA can be installed on-prem, or in a data center, and it does not require any external network access. It exposes a REST API that can be called by clients in the same network to request arbitrary amounts of true random bytes.

---
# How do we ensure true randomness?

The entropy generated by the QEA  is continuously tested using the [NIST SP800-22](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-22r1a.pdf) entropy source validation test suite. If any of the tests fail, then that entropy source is cut off until its output passes tests again.

The appliance also includes an extensive set of hardware health monitors that shut down the entropy source at the card level in the event of any hardware failure or anomaly.

---
# Performance

**Max API throughput:** ~2,500,000 256-bit keys per second

**Max Entropy card output:** ~1,500 Mb/s

---
# Installation

The QEA comes with Ubuntu Server v22.04 installed. Users will receive login credentials which they can use to perform any necessary admin tasks.

The QEA can be installed on-prem or in a datacenter rack. Once the appliance is connected to the network interface, the user must log in and configure its network interface (see the [Ubuntu docs](https://ubuntu.com/server/docs/configuring-networks) for a detailed guide on how to set up networking on Ubuntu Server).

---
# Interacting with the appliance

The QEA listens for incoming requests on port 80.

The root path (“/”) returns a UI that displays various metrics, and health reports. This UI can also be used to download application log files for troubleshooting purposes.

Client applications can request a configurable amount of entropy from the entropy API, which is served from the “/api/v1/” route. The complete spec for the API can be found below.

---
# OpenAPI spec

```yaml
openapi: 3.0.0
info:
  title: Entropy API Schema
  description: Entropy API Schema
  version: 1.0.0

paths:
  /api/v1/get_entropy:
    post:
      summary: Get entropy
      description: Returns blocks of quantum entropy. 
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                block_size:
                  type: integer
                  description: Size of each entropy block in bytes.
                  format: byte
                  minimum: 1
                  maximum: 1024
                block_count:
                  type: integer
                  description: Number of entropy blocks. Defaults to 1.
                  default: 1
                  minimum: 1
                  maximum: 512
      responses:
        '200':
          description: Entropy successfully generated.
          content:
            application/json:
              schema:
                type: object
                properties:
                  entropy:
                    type: array
                    items:
                      type: string
                      format: byte
                    description: Base64 encoded byte string representing the generated entropy.
                  extensions:
                    type: array
                    items:
                      type: object
                    description: Optional array of JSON objects representing extensions.
                example:
                  entropy: ["dWLmTxePnl5l9bnwb1qAAQ==",
                            "DnDqtrbysUoRwr9Meko+ug==",
                            "b//8fWTqpGWOFwbNNcQORQ==",
                            "9LhJWGYXQjt7x8/V1QBarw=="]
                  extensions: []
       
        '503':
          description: Entropy capability source unavailable.

  /api/v1/get_capabilities:
    get:
      summary: Retrieve Entropy Capabilities
      description: This endpoint retrieves the capabilities of the entropy source.
      responses:
        '200':
          description: Capabilities successfully retrieved.
          content:
            application/json:
              schema:
                type: object
                properties:
                  entropy:
                    type: object
                    properties:
                      min_block_size:
                        type: integer
                        description: Minimum block size in bytes.
                      max_block_size:
                        type: integer
                        description: Maximum block size in bytes.
                      min_block_count:
                        type: integer
                        description: Minimum block count.
                      max_block_count:
                        type: integer
                        description: Maximum block count.
                      entropy_types:
                        type: array
                        items:
                          type: string
                        description: Optional array of strings describing possible entropy source variations
                        example: ["quantum"]
                      extensions:
                        type: array
                        items:
                          type: object
                        description: Optional array of JSON objects representing extensions.
                  healthtest:
                    type: object
                    properties:
                      test_threshold:
                        type: array
                        items:
                          type: object
                          properties:
                            test_type:
                              type: string
                              description: Test performed, e.g., nist_90b, dieharder, vendor_test1, etc.
                            good:
                              type: number
                              format: float
                              description: Test value for good quality entropy range, e.g., 0.95.
                            warning:
                              type: number
                              format: float
                              description: Test value for low quality entropy range, e.g., 0.90.
                            error:
                              type: number
                              format: float
                              description: Test value for bad quality entropy range, e.g., 0.85.
                      extensions:
                        type: array
                        items:
                          type: object
                        description: Optional array of JSON objects representing extensions.
```
---
# Server Specs

|||
|:---|:---|
| **Dimensions** | 17" x 21.3" x 1.75"|
| **Processor** | One Intel® Xeon® Processor E-2300 (Rocket Lake) Product Family |
| | Supports CPU TDP up to 95W |
| **System Memory** | 2 channels DDR4 / 2 DPC UDIMM ECC Up to 3200 MT/s. |
| | Total 4 memory slots; up to 128GB |
| **Drive Bays** | 3.5" 1 (SATA) |
| | 2.5" 2 (1 x shared with 3.5") |
| | M.2 2 x M.2(NGFF)/M-Key/22110 |
| **Expansion Slots** | 2 x PCIe Gen4 x8 slots |
| | 1 x PCIe Gen3 x8 slot (with x4 link) |
| **On-board Devices** | 6x SATA 6G ports (4x in miniSAS HD + 2x 7pin + 2x M.2)|
| | Aspeed AST2500 Advanced PCIe Graphics & Remote Management Processor |
| | Baseboard Management Controller
| | Intelligent Platform Interface 2.0 (IPMI 2.0)
| | iKVM, Media Redirection, IPMI over LAN, Serial over LAN
| | Intel® I350 AM4/AM2 co-design to support 2/4 x GbE (SKU option)
| | Realtek RTL8211EL for BMC dedicated management port
| | 2D Video Graphic Adapter with PCIe bus interface
| **Rear I/O** | LAN: 3 x GbE RJ45 (2 x shared, 1 x dedicated)
| | USB: 2 x USB 3.0 Type A
| | Graphic: Mini-display port (enabled with specified CPU)
| | Serial Port: 1 x COM by 3.5mm audio jack
| **Power Supply**|  300W 1+1 redundant power supply 80+ Gold
| **System Cooling** | 3 x 40x56mm hot swap fans