---
description: Start Core By Running Testnet On Your Local Computer
---

# Spinning Up Your First Testnet

With the above dependencies installed, you are all set to start your first testnet. Here are the steps to doing so:

## Step 1: Start Docker Testnet Database

You already generated docker files during the[ development environment setup](setting-up-your-development-environment.md#step-7-1-database-setup-using-docker) \(if not please run the following commands as specified [here](setting-up-your-development-environment.md#step-7-1-database-setup-using-docker)\).

```bash
cd core/docker/development/testnet #testnet docker folder
docker-compose up postgres #start postgres testnet container
```

## Step 2: Testnet Network Boot

```bash
cd core/packages/core 
yarn full:testnet #run the testnet blockchain on your loca computer
```

