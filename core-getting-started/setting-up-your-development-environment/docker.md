---
description: Explaining How To Set Up Docker Development Environment
---

# Docker

## Introduction

Docker is the de facto industry standard for packaging applications into a container. By doing so, all dependencies, such as the language runtimes, operating system, and libraries are combined with the product.

{% hint style="info" %}
This guide is for setting up the development environment with Docker. If you are looking for ARK Core Production ready Docker images, they are now available at [Docker Hub](https://hub.docker.com/r/arkecosystem/core), but are not meant to be used for development purposes.
{% endhint %}

In the next sections we will explain two approaches on how you can setup you development environment with docker:

1. \*\*\*\*[**Run a PostgreSQL container while using NodeJS from your local environment**](docker.md#approach-1-containerize-only-the-persistent-store)\*\*\*\*
2. \*\*\*\*[**Run a PostgreSQL container, build and run ARK-Core using a mounted volume**](docker.md#approach-2-serve-ark-core-as-a-collection-of-containers)\*\*\*\*

## Base Step: Generate the Docker Configurations

ARK Core include several `Dockerfile` and `docker-compose.yml` templates to ease development. They can be used to generate different configurations, depending on the network and token.

For instance, you could use this command \(to be run from `core` root folder\):

```bash
yarn docker ark
```

This command creates a new directory \(`docker`\) that contains 1 folder per network. You can read more about generating of Docker configurations [here.](linux.md#step-7-1-database-setup-using-docker)

## Approach 1: Containerize Only the Persistent Store

**This approach runs a PostgreSQL container while using NodeJS from your local environment.** This configuration is well suited when you are not developing ARK Core, but instead working with the API. By tearing down the PostgreSQL container, you reset the Nodes blockchain.

{% hint style="danger" %}
PostgreSQL is run in a separate container and its port gets mapped to your localhost, so you should **NOT** have PostgreSQL running locally.
{% endhint %}

```bash
cd docker/development/$NETWORK     # (NETWORK = testnet || devnet)
docker-compose up postgres
```

To run the Postgres container in the [background](https://docs.docker.com/engine/reference/run/) execute the following command:

```bash
docker-compose up postgres -d
```

_In case you need to start with a clean Database:_

```bash
docker-compose down -v
docker-compose up postgres -d
```

## Approach 2: Serve Core Server as a Collection of Containers

**This approach runs a PostgreSQL container, builds and runs ARK-Core using a mounted volume.** When a container is built, all files are copied inside the container. It cannot interact with the host's filesystem unless a directory is specifically [mounted](https://docs.docker.com/storage/volumes/) during container start. This configuration works well when developing ARK Core itself, as you do not need to rebuild the container to test your changes.

{% hint style="success" %}
Along with PostgreSQL container, now you also have a NodeJS container which mounts your local ark-core git folder inside the container and installs all NPM prerequisites.
{% endhint %}

```bash
cd docker/development/$NETWORK      # (NETWORK = testnet || devnet)
```

```bash
docker-compose up -d
```

_You can now enter your ark-core container and use NodeJS in a Docker container \(Linux environment\)._

```bash
docker exec -it ark-$NETWORK-core bash
```

_Need to start everything from scratch and make sure there are no remaining cached containers, images or volumes left? Just use the **purge\_all.sh** script._

{% hint style="danger" %}
Development files/presets are not Production ready. Official Production ARK-Core Docker images are now available at [Docker Hub](https://hub.docker.com/r/arkecosystem/core).
{% endhint %}

