+++
title = "Quickstart: Add Secure Messaging to your App"
date = 2021-10-18T09:01:22-04:00
weight = 20
chapter = false
+++

Get started with the Qrypt Security SDK by building a simple secure messaging app. 

We will use [Azure Communication Services](https://azure.microsoft.com/en-us/services/communication-services/#overview) as our messaging back-bone for this app. However, you can use the messaging infrastructure that makes sense for you. The Qrypt Security SDK can layer into a wide variety of messaging services from Azure Communication Services to SendBird to RabbitMQ and many more.

To learn more about Secure Messaging concepts, visit the secure messaging conceptual documentation.

## Sample Code

Find the finalized code for this quickstart on [GitHub](https://github.com/QryptInc/qrypt-security-dotnet-quickstarts).

## Prerequisites

Before you get started, make sure to:

- Install [.NET 5](https://dotnet.microsoft.com/download/dotnet/5.0).
- Install [Visual Studio Code](https://code.visualstudio.com/).
- Create an Azure account with an active subscription. For details, see [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- Create an Azure Communication Services resource. For details, see Create an [Azure Communication Services resource](https://docs.microsoft.com/en-us/azure/communication-services/quickstarts/create-communication-resource). You'll need to record your resource endpoint and access key for this quickstart.

This Quickstart has been tested using:
- .NET 5
- Visual Studio Code v1.61.2
- Qrypt Security SDK - post_quantum v0.3.4

## Setting up
**Gettting started**

Follow the instructions in [Getting Started](/sdk/quickstarts/getting-started/) to locally stage the Qrypt Security post-quantum SDK NuGet package.

**Setup Environment Variables**

To make this Quickstart as simple as possible, we are using environment variables to store our state. Two environment variables must be setup before hand. The others will be dynamically created.

| Environment Variable | Description |
|---|---|
| COMMUNICATION_SERVICES_ENDPOINT | Set this to your Azure Communication Services endpoint value for the Azure Communication Services resource you created in Prerequisites above. |
| COMMUNICATION_SERVICES_ACCESS_KEY | Set this to your Azure Communication Services access key for the Azure Communication Services resource you created in Prerequisites above. |

**Download the code**

Find the finalized code for this quickstart on [GitHub](https://github.com/QryptInc/qrypt-security-dotnet-quickstarts).

Clone the repository and open the *add-chat* folder in Visual Studio Code.


## Build the code

To build the code in Visual Studio Code:

`Ctrl-Shift-b | build - ChatQuickStart`

## Run the code

Run as Alice first. Navigate to the debug tab in Visual Studio Code and select from the debug drop-down:

`Alice - ChatQuickstart`

Then run as Bob. Select from the debug drop-down:

`Bob - ChatQuickstart`

The terminal in Visual Studio Code will display:

    hello world

## Understanding the code

### Environment Variables

To make this Quickstart as simple as possible, we are using environment variables to store our state. Two environment variables must be setup before hand. The others will be dynamically created.

| Environment Variable | Description |
|---|---|
| COMMUNICATION_SERVICES_ENDPOINT | Set this to your Azure Communication Services endpoint value. |
| COMMUNICATION_SERVICES_ACCESS_KEY | Set this to your Azure Communication Services access key. |
| COMMUNICATION_SERVICES_IDENTITY_ALICE | This will be dynamically created by the Quickstart for each run and will be set to Alice's Azure Communcation Services identity id. |
| COMMUNICATION_SERVICES_IDENTITY_BOB | This will be dynamically created by the Quickstart for each run and will be set to Bob's Azure Communcation Services identity id. |
| COMMUNICATION_SERVICES_CHAT_THREAD | This will be dynamically created by the Quickstart for each run and will be set to the Azure Communcation Services chat thread id for the chat between Alice and Bob. |

### The project file
**x64 Builds Only**

The Qrypt Security SDK is available for x64 builds only. We can see that this is specifed in the project file here:

    <Platforms>x64</Platforms>

**NuGet Packages**

We can see the appropriate NuGet references have been added for Azure Communication Services and the Qrypt Security post-quantum SDK.

    <ItemGroup>
        <PackageReference Include="Azure.Communication.Chat" Version="1.0.1" />
        <PackageReference Include="Azure.Communication.Identity" Version="1.0.1" />
        <PackageReference Include="QryptSecurity_post_quantum" Version="0.3.4" />
    </ItemGroup>

## Building the code

A Visual Studio Code task has been setup in:

`.vscode\tasks.json`

for this purpose.

### Running the code with command Line Arguments

Either **alice** or **bob** must be specified as command line arguments. The code will follow a specific path for sending or receiving based on the argument specified. A complete test run of the Quickstart entails:

1. Running as alice to send a secure message to bob.
2. Running as bob to receive the secure message from alice.

| Command Line Argument | Description |
|---|---|
| alice | Run as **alice** first. This will send a secure "hello world" message to **bob**. |
| bob | Run as **bob** second. This will receive the secure "hello world" message from **alice**. |

Visual Studio Code launch targets have been setup in

`.vscode\launch.json`

for this purpose.

## Next steps

In this quickstart you learned how to:

- Create a messaging chat client
- Create a chat thread with two users
- Securely send a message to the thread by layering in calls to the Qrypt Security SDK
- Securely receive messages from a thread by layering in calls to the Qrypt Security SDK

You may also want to:

- Learn about secure messaging concepts
- Familiarize yourself with the Qrypt Security SDK
