---
description: Create and run a simple core module in three steps!
---

# Creating Your First Core Module

## Step 0: Prepare Your Local Development Environment

Many components are required to have a proper environment setup for the development of your ARK Core module. You can view instructions on how to setup your development environment here:

{% page-ref page="../../core-getting-started/setting-up-your-development-environment/" %}

## Step 1: Create A New Module From A Template

{% hint style="info" %}
GitHub learning repository has [a starter module template project available](https://github.com/learn-ark/dapp-core-module-template). You can create a new module by creating [a new GitHub repository ](https://github.com/new)and selecting the correct template: **learn-ark/dapp-core-module-template.**
{% endhint %}

{% embed url="https://github.com/learn-ark/dapp-core-module-template" caption="dApp Core Module Starter Template" %}

After your repository has been created, you can add it as a submodule within the `core/plugins` folder and start changing the defaults.

```bash
cd plugins/
git submodule add -f https://github.com/your-username/your-core-plugin-repo-name
```

### 1.1 Module Configuration

We need to make some changes to the project first. Make sure to modify the default names for the files:

* \*\*\*\*[**package.json**](https://github.com/learn-ark/dapp-core-module-template/blob/master/package.json) \(model name, dependencies and other npm fields\)
* \*\*\*\*[**src/defaults.ts**](https://github.com/learn-ark/dapp-core-module-template/blob/master/src/defaults.ts) \(settings\)
* \*\*\*\*[**src/index.ts**](https://github.com/learn-ark/dapp-core-module-template/blob/master/src/index.ts) \(exports\)
* \*\*\*\*[**src/plugin.ts** ](https://github.com/learn-ark/dapp-core-module-template/blob/master/src/plugin.ts)\(registration logic and properties definitions\)

The name of our module is **@vendorname/your-dapp-name**. Make sure to change the name in your **package.json** accordingly. It is recommended to scope your packages with a prefix like `@your-vendor/` to distinguish it from other **npm** packages. Check [https://docs.npmjs.com/misc/scope](https://docs.npmjs.com/misc/scope) for more information.

### 1.2 Adding Module Dependencies

If your package relies on any dependencies you should install them via [lerna add](https://github.com/lerna/lerna/tree/master/commands/add) the plugin you are developing.

```bash
lerna add dependency-name --scope=@vendor/demo-plugin --dev
```

Once everything is set up and configured, we can move on to developing the plugin.

## Step 2: Module Registration Within Network Configuration

{% hint style="info" %}
In order to make sure that your plugin is registered and loaded when **core node starts** you need to modify the **plugin.js** file related to the current [network run mode.](../../concepts/core-node-running-modes.md#available-running-modes)  
{% endhint %}

Since, we are running[ local development environment](../../core-getting-started/setup-local-blockchain-explorer.md) we need to edit the Testnet configuration \(folder: `core/packages/core/bin/config/testnet/plugins.js` and add our **module name** to the list of loaded modules. This is also a good place to set up module default properties, that are defined in **default.ts** file in our module root folder.

{% code title="plugins.js" %}
```javascript
module.exports = {
    // Order is IMPORTANT! 
    // Modules are loaded in the same order as they are listed
    "@arkecosystem/core-event-emitter": {},
    "@arkecosystem/core-logger-pino": {},
    "@arkecosystem/core-p2p": {}, 
    "@arkecosystem/core-blockchain": {},
    "@arkecosystem/core-snapshots": {},
    ...
    ... // other core plugins and their settings
    ...
    "@your-vendor/your-module-name-from-package.json": {
        // Here we set the module properties that are defined in defaults.ts file
        enabled: true,
        host: "0.0.0.0",
        port: 8081,
        ...
        ...
    }
};

```
{% endcode %}

{% hint style="danger" %}
Make sure to run **yarn setup** from the **core** root folder when you change or add code to **core/plugins.** This command takes a long time, just let it finish.
{% endhint %}

After **yarn setup** completes you should see the following output:

```bash
lerna success - @arkecosystem/core-vote-report
lerna success - @arkecosystem/core-wallet-api
lerna success - @arkecosystem/core-webhooks
lerna success - @arkecosystem/core
lerna success - @arkecosystem/crypto
lerna success - @vendorname/dappname # Your Module 
```

Every plugin that is being registered in this file will be automatically **loaded one after another** to guarantee that all required data is available, so make sure your custom modules are placed in the right spot.

## Step 3: Running Your dApp 

Start local blockchain with Testnet running on your developer computer. Follow steps defined in here: 

{% page-ref page="../../core-getting-started/spinning-up-your-first-testnet.md" %}

If you already have compiled and running core, just go to `core/packages/core` and run the `yarn full:testnet` command.

**After the local Testnet starts, the log should show that dApp Module was loaded and run**. Console output should look like this \(if you haven't changed the source code from the template\):

```bash
[2019-10-22 11:13:27.161] INFO : Starting dApp
[2019-10-22 11:13:27.161] INFO : Initialization of dApp
```

{% hint style="success" %}
**Congratulations**. Your first distributed blockchain application is loaded, running and compatible with any ARK Core based blockchain. 
{% endhint %}

Feel free to look into helper class `common/base-service.ts` that exposes important Core Platform building blocks that you can work with. Your newly developed classes can extend this class and gain access to:

* wallets and state
* transaction pool
* blockchain protocol
* events
* database
* api 
* logger
* **well...actually any core-module :\)**

