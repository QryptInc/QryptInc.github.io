+++
title = "Getting started"
date = 2021-10-18T09:01:22-04:00
weight = 10
chapter = false
+++

The Qrypt Security SDK is available as a NuGet package targeting .NET Standard 2.0 and .NET 5.

Currently the NuGet packages are available via download from our portal site only. We are researching moving distribution to NuGet.org.

## Setup a local NuGet Feed

Download an appropriate Qrypt SDK package from the Qrypt Portal and place it in a folder you would like to use as your local NuGet feed.

{{< tabs >}}
{{% tab name="Visual Studio" %}}
On the Tools menu, select Options > NuGet Package Manager > Package Sources. Select the green plus in the upper-right corner and enter the name and source URL below.

**Name**

qrypt-security

**Source**

Use the browse button to select the folder you placed the NuGet package in.

{{% /tab %}}

{{% tab name="Visual Studio Code" %}}
Add a nuget.config file to your project, in the same folder as your .csproj or .sln file

    <?xml version="1.0" encoding="utf-8"?>
    <configuration>
        <packageSources>
            <clear />
            <add key="qrypt-sdk" value="folder you placed NuGet package in." />
        </packageSources>
    </configuration>

**Example**

    <?xml version="1.0" encoding="utf-8"?>
    <configuration>
        <packageSources>
            <clear />
            <add key="qrypt-sdk" value="c:\packages" />
        </packageSources>
    </configuration>


<add key="TestSource" value="c:\packages" />

{{% /tab %}}
{{< /tabs >}}