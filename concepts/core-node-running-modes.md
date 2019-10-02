---
description: >-
  This page explains different running modes that are available to our Core
  Server
---

# Core Node Running Modes

## Available Running Modes

Core Server can be run in the following general modes:

* **Relay Mode**- listens to blockchain traffic and replicates and validates block data 
* **Forger Mode** - creates new blocks and broadcasts them via relay nodes to the p2p network
* **Relay and Forger Mode** - both run under a single process

### How To Starting a Node?

If you want to start a node which consists of a `relay` and `forger` process you can use any of the following commands \(inside `packages/core`\).

* `yarn start:mainnet` =&gt; `packages/core/bin/config/networks/mainnet`
* `yarn start:devnet` =&gt; `packages/core/bin/config/networks/devnet`
* `yarn start:testnet` =&gt; `packages/core/bin/config/networks/testnet`

### How To Start a Relay?

If you want to start a `relay` you can use any of the following commands \(inside `packages/core`\).

* `yarn relay:mainnet` =&gt; `packages/core/bin/config/networks/mainnet`
* `yarn relay:devnet` =&gt; `packages/core/bin/config/networks/devnet`
* `yarn relay:testnet` =&gt; `packages/core/bin/config/networks/testnet`

### How To Star a Forger? <a id="starting-a-forger"></a>

If you want to start a `forger`, you can use any of the following commands \(inside `packages/core`\).

* `yarn forger:mainnet` =&gt; `packages/core/bin/config/networks/mainnet`
* `yarn forger:devnet` =&gt; `packages/core/bin/config/networks/devnet`
* `yarn forger:testnet` =&gt; `packages/core/bin/config/networks/testnet`

### Debugging <a id="debugging"></a>

It is possible to run a variation of these commands that enables the [Node debugger](https://nodejs.org/api/debugger.html):

* `yarn debug:start`
* `yarn debug:relay`
* `yarn debug:forger`

A good introduction about how to use the debugger is the [guide to debugging of Node.js](https://nodejs.org/en/docs/guides/debugging-getting-started/).

### Tests <a id="tests"></a>

Every package that is developed should provide tests to guarantee it gives the expected behaviour.

Our tool of choice for tests is [Jest](https://facebook.github.io/jest/) by Facebook which provides us with the ability to add custom matchers, snapshot testing and parallelizes our test runs.

All packages have a `yarn test` command which you should run before sending a PR or pushing to GitHub to make sure all tests are passing. You could use `yarn test:watch` to listen to changes on the files and run the tests automatically.

Additionally, we provide a variant \(`yarn test:debug`\) that enables the [Node debugger](https://nodejs.org/api/debugger.html).

With theory covered let's start our first local Testnet as shown below.

