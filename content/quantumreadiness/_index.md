+++
menuTitle = "Quantum Readiness"
title = "Quantum Readiness with Qrypt"
date = 2024-09-24T08:59:39-04:00
weight = 30
disableToc = "true"
+++

## Overview

Quantum Readiness is Qrypt's single pane management console for all Qrypt products. Currently everything is containerized to support a wide range of machines and target environments.

## General setup

There are ports to set that allow frontend to backend communication. There are defaults set in the docker-compose.yaml.

### Local

There is a provided docker-compose.yaml. Run `docker-compose up -d` to bring up everything. The frontend should be available at http://localhost:8081/.

### Cloud kubernetes

Currently this is tested against the Azure cloud. This uses Microsoft Entra ID as the authentication system. WireGuard sidecar container are not covered here, but can be set up for further network security between external connections to this cluster. There will be an example kustomize yaml to follow. Below is a manual setup.

Create a Microsoft Entra ID to be used as authentication. Note the link, client id, client secret, and redirect url.

Deploy a postgres database to be used in conjection with the backend.

Deploy the backend proxy container. The following ports will need to be exposed to other pods 8080, 50051, 50052, 50053.

Deploy the backend container. Make sure the set the DBCONNSTR environment variable with a connection string to the post res database.

Deploy the web api container. Make sure to set the BACKEND_API environment variable to the backend proxy and the 50051 port. Set the EXPRESS_LISTEN_PORT environment variable to the port to listen for incoming requests.

Deploy the auth container. Make sure to set the LOGOUT_REDIRECT_URL to the frontend container's login URI. Set the REDIRECT_URL to the frontend container's auth-redirect URI. Set the EXPRESS_LISTEN_PORT environment variable to the port to listen for incoming requests. Set AUTHORITY environment variable to the Entra ID link. Set CLIENT_ID environment variable to the Entra ID client id. Set the CLIENT_SECRET environment variable to the Entra ID client secret.

Deploy the frontend container. The default serving port is 5173. Make sure to set the VITE_AUTH_API to the proxy container's 50052 port. Make sure to set the VITE_BACKEND_API to the porxy container's 50053 port.

The frontend should be available at the hostname set up for the cluster's external IP and the exposed frontend container. This should bring you to a login screen which is hooked up to the Entra ID set up.

## Post quantum TLS proxy setup

A WireGuard container is set up to run along side to allow for a symmetric key connection with the use of a preshared key. This will involve a standard WireGuard setup with generating keys and updating the WireGuard configuration to allow a connections. Please see our WireGuard sidecar container as an example.

To add a post quantum TLS proxy, go through the UI and make sure the add the host name/ip and port that the proxy is set up to listen to GRPC connections. The UI should then show the proxy.

## On-Prem appliance setup

The on-prem appliance has to be reachable from the network which quantum readiness is deployed on. To add an on-prem appliance, go to the "on-prem appliance" tab and click "Add an appliance". Make sure to use the correct hostname or IP and port to connect to.

### Demo

Please reach out to [Qrypt](https://www.qrypt.com/contact/) for a demo or more information.
