---
description: >-
  A Step-By-Step Guide on How To Prepare a Fully Functional Development
  Environment
---

# Development Environment Setup

## Introduction

ARK Core is written in [TypeScript](https://github.com/microsoft/typescript), and it has been using [Lerna](https://github.com/lerna/lerna) to manage the development and publication of its packages and uses [Node.js](https://nodejs.org) as execution environment. 

This guide will take you through the basic steps of setting up a development environment from scratch on a fresh Linux \(\*.deb based\) box. If you don't have access to a Linux box you can quickly setup one on [DigitalOcean](https://cloud.digitalocean.com) by using this referral link: [https://m.do.co/c/09d061526b12](https://m.do.co/c/09d061526b12).

{% hint style="info" %}
This tutorial is for **setting up the development environment** for ARK core. If you are looking to run our node  in production, we provide other tools and resources, such as:

* [AR](https://ark.io/deployer)[K Deployer](https://ark.io/deployer) - Create Blockchain in Minutes
* [Node Installation Instructions](https://docs.ark.io/tutorials/node/setup.html#introduction) - Server Installation Instructions For Production Node
{% endhint %}

For Windows Development Environment Setup please follow Windows docker environment setup. \(TODO LINK\)

## Step 1: User setup

We will create a new user `ark` and add this user to the `sudoers` group \(allowing root execution if needed\). You can skip this step as a developer and continue to next steps below.

If you are running on a fresh cloud box, like for example [DigitalOcean](https://cloud.digitalocean.com/), then create a user with the following commands below.

```bash
sudo adduser ark
sudo usermod -aG sudo ark

# login as ark user
sudo su - ark
```

## Step 2: Install Git Source Control System

As the most popular version control software in existence, Git is a staple of many developer workflows, and ARK is no exception. Downloading Git will allow you to clone the latest version of ARK Core.

```bash
sudo apt-get install -y git curl apt-transport-https update-notifier
```

## Step 3: Install Node.js Runtime

As ARK Core is written exclusively in [Node.js](https://nodejs.org/), the server-side framework for JavaScript, Typescript, installing Node.js is a necessity for core development. The code below installs Node.js from source.

```bash
sudo wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
(echo "deb https://deb.nodesource.com/node_11.x $(lsb_release -s -c) main" | sudo tee /etc/apt/sources.list.d/nodesource.list)
sudo apt-get update
sudo apt-get install nodejs -y
```

## Step 4: Install Yarn Package Manager

[Yarn](https://yarnpkg.com/) is a package manager that seeks to build upon the foundation of Node's npm. Although yarn is not a strict requirement, in many cases it works faster and more elegantly than npm. Most ARK developers use yarn, and as such, you will see yarn commands often used throughout our documentation.

```bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
(echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list)
sudo apt-get update
sudo apt-get install -y yarn
```

## Step 5: Install Dependencies

Dependencies are needed for `core` to be compiled, run and controlled while living inside you linux based environment. To command below installs some of those needed dependencies that are used by core or related scripts.

```bash
sudo apt-get install build-essential libcairo2-dev pkg-config libtool autoconf automake python libpq-dev jq -y
```

## Step 6: Clone The Core Repository

Let's clone our `core` repository and run the initial `yarn setup` command. We will also checkout the latest `develop` branch. 

`yarn setup` command leverages [Lerna](https://github.com/lerna/lerna) to clean, bootstrap and build the core packages \(including transpiling typescript\). For mode information look into core's `package.json` file in the root folder.

```bash
git clone https://github.com/arkecosystem/core
cd core
git checkout develop

yarn setup  #run Lerna to clean, bootstrap and build the core packages
```

## Step 7: Setting Up a Development Database

ARK Core stores all the blockchain data in a [PostgreSQL](https://www.postgresql.org/) database. You have two options on how to setup your development database. 

### Step 7.1 Database Setup Using Docker

If you are already using `Docker` and  have  `docker-compose` installed, then you can generate docker files from the command line, with the `yarn docker ark` command where \(ark is the name of the `network` for which you want to generate docker files\). For now let's stick with `ark` as the default name of the network.

Executing the command `yarn docker ark` in the root folder of the previously cloned repository, like this: 

```bash
cd core  #root folder of the cloned repository
yarn docker ark 
```

will generate the following docker files inside our `core/docker` folder \(see folder tree below\):

```bash
#core/docker tree in the cloned repository folder
├── development
│   ├── devnet
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   │   ├── entrypoint.sh
│   │   ├── purge_all.sh
│   │   └── restore.sh
│   ├── mainnet
│   │   └── docker-compose.yml
│   ├── testnet #this is the folder where we will start our PostgreSQL testned DB
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   │   ├── entrypoint.sh
│   │   ├── purge_all.sh
│   │   └── restore.sh
│   └── unitnet
│       ├── docker-compose.yml
│       └── purge.sh
└── production
...
```

To start the PostgreSQL docker container we must go into the corresponding folder and run the `docker-compose` command. For testnet we need to run the following:

```bash
cd core/docker/development/testnet
docker-compose up postgres #postgres is the name of the PostgreSQL container
```

The `docker-compose up postgres` will start PostgresSQL container and expose it to our core via standard PostgreSQL port 5432. 

### Step 7.2 Database Setup by Installing Locally

If you don't want to install and run docker on your local computer you can still install PostgreSQL database natively on your running operating system. For \*.deb based Linux systems the commands are the following:

```bash
sudo apt-get install postgresql postgresql-contrib -y
sudo -i -u postgres psql -c "CREATE USER ark  WITH PASSWORD 'password' CREATEDB;"
sudo -i -u postgres psql -c "CREATE DATABASE ark_testnet WITH OWNER ark;"
sudo -i -u postgres psql -c "CREATE DATABASE ark_devnet WITH OWNER ark;"
```

The commands above install PostgreSQL database locally and create databases for running testnet and devnet networks with user `ark` as the database owner. If you have skipped the Step 1: User setup, you have to change `ark` user to your development username, usually the logged in username. 

## Run Above Commands Together In One Setup Script

First create user ARK with default password `password`. This will make it easier for us to work with default settings.

{% code-tabs %}
{% code-tabs-item title="create-user.sh" %}
```bash
#!/usr/bin/env bash
sudo adduser ark
sudo usermod -aG sudo ark

# login as ark user
sudo su - ark
```
{% endcode-tabs-item %}
{% endcode-tabs %}

Dependencies installation script \(to be run under `ark` user\).

{% code-tabs %}
{% code-tabs-item title="dev-setup.sh" %}
```bash
#!/usr/bin/env bash
sudo apt-get install -y git curl apt-transport-https update-notifier

sudo wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
(echo "deb https://deb.nodesource.com/node_11.x $(lsb_release -s -c) main" | sudo tee /etc/apt/sources.list.d/nodesource.list)
sudo apt-get update
sudo apt-get install nodejs -y


curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
(echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list)
sudo apt-get update
sudo apt-get install -y yarn

sudo apt-get install build-essential libcairo2-dev pkg-config libtool autoconf automake python libpq-dev jq -y

sudo apt-get install postgresql postgresql-contrib -y
sudo -i -u postgres psql -c "CREATE USER ark  WITH PASSWORD 'password' CREATEDB;"
sudo -i -u postgres psql -c "CREATE DATABASE ark_testnet WITH OWNER ark;"
sudo -i -u postgres psql -c "CREATE DATABASE ark_devnet WITH OWNER ark;"
```
{% endcode-tabs-item %}
{% endcode-tabs %}



