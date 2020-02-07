---
description: >-
  This is a basic example of ARK Core dApp development, by using The Core GTI
  Engine and modular approach.
---

# Running The Example

**This Example is currently operational only on our** [**core/develop**](https://github.com/ArkEcosystem/core/tree/develop) **branch!**

This dApp enables a new transaction type on the ARK Core blockchain. New transaction types follows existing blockchain protocol. You can fork or view full example code here:

{% embed url="https://github.com/learn-ark/dapp-custom-transaction-example/" caption="Custom Transaction Example Source Code" %}

## Example Goal: 

**Storyline:**  
To develop and register  a new business identity on the Core blockchain \(with custom fields like name and website\) we need to implement the supporting business logic in the form of a dApp enabling new transaction type called **BusinessRegistration**.

**TransactionType name**: BusinessRegistration 

**Custom Fields**:

* name: string
* website: string \| uri

When a custom transactions is registered it is fully compatible with existing [API \(api/transactions/\)](https://api.ark.dev/public-rest-api/endpoints/transactions) endpoints.

The same logic was used to build our `core-magistrate` transactions. You can check the source code here:

* [core-magistrate-transactions](https://github.com/ArkEcosystem/core/tree/develop/packages/core-magistrate-transactions)
* [core-magistrate-crypto](https://github.com/ArkEcosystem/core/tree/develop/packages/core-magistrate-crypto)

{% hint style="success" %}
One of the **best practices** we encountered was splitting of the custom transaction logic into two separate packages: **crypto** and **transactions**. 

This makes it easier to include in light-client application, where only payload generation is needed \(the core-magistrate-crypto part\), and the core protocol validation still remains in the main package \(the core-magistrate-transaction package\) on the core node.
{% endhint %}

## Load And Run The Custom Transactions dApp

We assume that you already have local development environment setup. If not head over here:

{% page-ref page="../../core-getting-started/setting-up-your-development-environment/" %}

After successful setup of local development environment follow the steps below:

### STEP 1: Checkout This dApp Project As a GitSubmodule

```bash
cd plugins/ #location for loading of custom non-core dApps
git submodule add -f https://github.com/learn-ark/dapp-custom-transaction-example
cd dapp-custom-transaction-example
```

### STEP 2: Load The dApp \(Custom Transactions module\) In The Corresponding Network Configurations.

Go to: `core/packages/core/bin/testnet`

```text
cd packages/core/bin/config/testnet
```

Locate file `plugins.js`. We will add our plugin name to the list of the loaded plugins. This means that core will pickup the plugin/dapp and load it for a specific network configuration. Add line `"@arkecosystem/custom-transactions": {}`: to in the file `plugins.js` file, so it looks something like this:

```javascript
    ......
    "@arkecosystem/custom-transactions": {}, // LOADING THE PLUGIN - ORDER IS IMPORTANT
    "@arkecosystem/core-state": {},
    "@arkecosystem/core-database-postgres": {
        connection: {
            host: process.env.CORE_DB_HOST || "localhost",
            port: process.env.CORE_DB_PORT || 5432,
            database: process.env.CORE_DB_DATABASE || `${process.env.CORE_TOKEN}_${process.env.CORE_NETWORK_NAME}`,
            user: process.env.CORE_DB_USERNAME || process.env.CORE_TOKEN,
            password: process.env.CORE_DB_PASSWORD || "password",
        },
    },
    ......
```

{% hint style="danger" %}
**Order of plugin/dapp loading is very important.** Since your plugin is adding new transaction types to the blockchain protocol, it **MUST** be registered before we load the  **@arkecosystem/core-state** module ****\(see example snippet above\).
{% endhint %}

### STEP 3: Loading The dapp/Plugin With A Separate Processes

In production environment we usually run two separate processes, one for a **relay** node and another one for **forger**. A relay node looks for the default **plugins.js** configuration and automatically loads the listed plugins \(see above\).

{% hint style="danger" %}
To register the custom-transaction plugin for another processes, we **MUST** add it to the **app.js** file in the folder: **core/packages/core/bin/config/network-name/app.js.**
{% endhint %}

 The file looks like this:

```javascript
module.exports = {
    cli: {
        core: {
            run: {
                plugins: {
                    include: [
                        "@arkecosystem/custom-transactions"
                    ],
                },
            },
        },
...... // More content
```

Add your plugin handle/name to all the include sections, so that the core will load the plugin when running other important processes.

### STEP 4: Setup Development Docker Database

Setup docker database config and run Postgres DB via Docker. Follow the steps from here: [https://learn.ark.dev/core-getting-started/spinning-up-your-first-testnet\#step-1-start-docker-testnet-database](https://learn.ark.dev/core-getting-started/spinning-up-your-first-testnet#step-1-start-docker-testnet-database)

### STEP 5: Start Local Testnet Blockchain

Start local blockchain with testnet running on your developer computer. Follow steps defined in here: [https://learn.ark.dev/core-getting-started/spinning-up-your-first-testnet\#step-2-testnet-network-boot](https://learn.ark.dev/core-getting-started/spinning-up-your-first-testnet#step-2-testnet-network-boot)

### STEP 6: Send New Custom Transaction To The Local Node

Send your new transaction type payload to the local blockchain node with the following `curl` command:

```bash
curl --request POST \
  --url http://127.0.0.1:4003/api/v2/transactions \
  --header 'content-type: application/json' \
  --data '      {
                "transactions":
                [
                        {
                                "version": 2,
                                "network": 23,
                                "typeGroup": 1001,
                                "type": 100,
                                "nonce": "3",
                                "senderPublicKey":
                                 "03287bfebba4c7881a0509717e71b34b63f31e40021c321f89ae04f84be6d6ac37",
                                "fee": "5000000000",
                                "amount": "0",
                                "asset":
                                        { "businessData": { "name": "google", "website": "www.google.com" } },
                                "signature":
                                 "809dac6e3077d6ae2083b353b6020badc37195c286079d466bb1d6670ed4e9628a5b5d0a621801e2763aae5add41905036ed8d21609ed9ddde9f941bd066833c",
                                "id":
                                 "b567325019edeef0ce5a1134af0b642a54ed2a8266a406e1a999f5d590eb5c3c" }
                ]
        }'
```

You should receive a response similar to this:

```javascript
{
    "data": {
        "accept": ["b567325019edeef0ce5a1134af0b642a54ed2a8266a406e1a999f5d590eb5c3c"],
        "broadcast": ["b567325019edeef0ce5a1134af0b642a54ed2a8266a406e1a999f5d590eb5c3c"],
        "excess": [],
        "invalid": []
    }
}
```

This means that transactions was accepted into the pool and broadcasted to the rest of the network. If you want to create more transaction payloads, just [use the BusinessTransactionBuilder to create and sign the payload data](https://github.com/learn-ark/dapp-custom-transaction-example/blob/master/__tests__/test.test.ts).

You can also setup a local Testnet blockchain explorer to view the accepter and created transaction. Follow the step here to run a local Testnet blockchain explorer:

{% page-ref page="../../core-getting-started/setup-local-blockchain-explorer.md" %}

