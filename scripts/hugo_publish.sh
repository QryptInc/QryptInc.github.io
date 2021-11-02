#!/bin/bash

# Copyright 2018-2021, Qrypt, Inc. All rights reserved.

# Display help menu
usage() {
    echo ""
    echo "hugo_publish.sh"
    echo "==============="
    echo ""
    echo "Publish SDK documentation to Azure Storage static web site."
    echo ""
    echo "Options:"
    echo "--help                    Displays help menu"
    echo ""
    echo "--publish_target=<option> Specify target for publishing."
    echo "                          Prod    - Publishing targeting prod."
    echo "                                    Note, this will only publish api docs"
    echo "                                    as hugo docs for prod go through GitHub."
    echo "                          Staging - Publishing targeting staging."
    echo "                          Bill    - Publishing targeting Bill's personal Azure subscription."
    echo "--enable_api=<option>     Publish api documentation. Defaults to False."
    echo "                          False - Do not publish api documentation."
    echo "                          True  - Publish api documentation."
    echo ""
    
    exit
}

# Parse input arguments
for i in "$@"
do
case $i in
    --help)
    usage
    shift
    ;;
    --publish_target=*)
    PUBLISH_TARGET="${i#*=}"
    shift
    ;;
    --enable_api=*)
    ENABLE_API="${i#*=}"
    shift
    ;;
    *)
    echo "Unknown option: $i"
    usage
    shift
    ;;
esac
done

# Validate input arguments and set defaults
if [[ "$PUBLISH_TARGET" != "Prod" && "$PUBLISH_TARGET" != "Staging" && "$PUBLISH_TARGET" != "Bill" ]]; then
    echo "Invalid --publish_target: $PUBLISH_TARGET"
    usage
fi
if [[ "$PUBLISH_TARGET" == "Prod" ]]; then
    BASE_URL=""
    ACCOUNT_NAME=""
    ACCOUNT_KEY=""
    AZURE_SUBSCRIPTION_ID=""
    API_URL=""
elif [[ "$PUBLISH_TARGET" == "Staging" ]]; then
    BASE_URL="TODO"
    ACCOUNT_NAME="TODO"
    ACCOUNT_KEY="TODO"
    AZURE_SUBSCRIPTION_ID="TODO"
    API_URL="TODO"
elif [[ "$PUBLISH_TARGET" == "Bill" ]]; then
    BASE_URL='TODO'
    ACCOUNT_NAME='TODO'
    ACCOUNT_KEY='TODO'
    AZURE_SUBSCRIPTION_ID="TODO"
    API_URL="TODO"
fi
if [[ "$ENABLE_API" == "" ]]; then
    ENABLE_API="False"
fi
if [[ "$ENABLE_API" != "True" && "$ENABLE_API" != "False" ]]; then
    echo "Invalid --enable_api: $ENABLE_API"
    usage
fi

# Move to root folder
cd ..

# az storage blob notes
# https://docs.microsoft.com/en-us/cli/azure/storage/blob?view=azure-cli-latest#az_storage_blob_upload_batch
# Environment variables:
# --account-key: AZURE_STORAGE_KEY.
# --acount-name: AZURE_STORAGE_ACCOUNT
# --auth-mode: AZURE_STORAGE_AUTH_MODE
# --connection-string: AZURE_STORAGE_CONNECTION_STRING
#
# IMPORTANT NOTES: 
# 1. For bash, you need to use az.cmd instead of az for Azure CLI.
# 2. But in a bash script you need to create a work-around as noted here:
#    https://stackoverflow.com/questions/42972086/azure-cli-in-git-bash
#    echo  "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd" $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} > "%SYSTEMROOT%\az"
#    Where we have placed the appropriate az file in our scripts folder.
# 3. We do not specify a subscription parameter here as subscription names can have spaces.
#    So make sure you are pointing to appropriate subscription.
#    Work-around, use subscription id.
# 4. Note single quotes around $web so $ sign is interpreted correctly

# Remove any previous files in our Azure Storage static web site
echo "***************************************"
echo "* PURGE FILES ON STATIC WEB SITE"
echo "***************************************"
scripts/az storage blob delete-batch \
    --source '$web' \
    --subscription $AZURE_SUBSCRIPTION_ID \
    --account-name $ACCOUNT_NAME \
    --account-key $ACCOUNT_KEY

# Prod builds for Hugo go through GitHub
if [[ "$PUBLISH_TARGET" != "Prod" ]]; then

    # TODO: This isn't working
    export HUGO_MENU.SHORTCUTS_url="$API_URL"

    # Do a clean hugo build
    echo "***************************************"
    echo "* HUGO BUILD"
    echo "***************************************"
    hugo \
        --baseURL="$BASE_URL" \
        --cleanDestinationDir

    # Publish our hugo output to our Azure Storage static web site
    echo "***************************************"
    echo "* PUBLISH DOCS FOLDER TO STATIC WEB SITE"
    echo "***************************************"
    scripts/az storage blob upload-batch \
        --source 'docs' \
        --destination '$web' \
        --subscription $AZURE_SUBSCRIPTION_ID \
        --account-name $ACCOUNT_NAME \
        --account-key $ACCOUNT_KEY
fi

# Are we publishing API docs?
if [[ "$ENABLE_API" == "True" ]]; then
    # Do a clean api build from our sibling QryptLib repo and stage in api folder
    # http://www.innovasys.com/help/dx2021.1/commandline.html
    echo "***************************************"
    echo "* API BUILD"
    echo "***************************************"
    DocumentXCommandLine.exe "..\QryptLib\docs\documentx\QryptLib.dxp"
    rm -rvf api
    mkdir api
    cp -r "../QryptLib/docs/documentx/build/Browser Help/." api
 
    # Publish our api output to our Azure Storage static web site
    echo "***************************************"
    echo "* PUBLISH API FOLDER TO STATIC WEB SITE"
    echo "***************************************"
    scripts/az storage blob upload-batch \
        --source  'api' \
        --destination '$web\api' \
        --subscription $AZURE_SUBSCRIPTION_ID \
        --account-name $ACCOUNT_NAME \
        --account-key $ACCOUNT_KEY
fi

