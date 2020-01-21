---
description: >-
  When you fork Core and plan to run your own network this milestone
  configuration will be the one of the most interest to you to test your network
  before going live in production.
---

# How to Use Milestones

## What Are Milestones and How Do They Work? <a id="what-are-milestones-and-how-do-they-work"></a>

{% hint style="success" %}
Milestones are a collection of height based configurations that determine things like how Core handles specific data, when new transaction types are valid or changes to fees and how many delegates are active as forgers.
{% endhint %}

Every-time a new block is received the height of a node changes and Core will check if there is a milestone that needs to be activated. Milestones are always merged from the earliest to the latest to ensure that all properties of the initial milestone are still intact and properties are only modified or added but never removed.

As previously explained the milestones are just collections of configurations that have keys and values. Let's take a look at the `devnet` milestones of ARK.

```javascript
[
  {
    "height": 1,
    "reward": 0,
    "activeDelegates": 51,
    "blocktime": 8,
    "block": {
      "version": 0,
      "maxTransactions": 50,
      "maxPayload": 2097152
    },
    "epoch": "2017-03-21T13:00:00.000Z",
    "fees": {
      "staticFees": {
        "transfer": 10000000,
        "secondSignature": 500000000,
        "delegateRegistration": 2500000000,
        "vote": 100000000,
        "multiSignature": 500000000,
        "ipfs": 0,
        "timelockTransfer": 0,
        "multiPayment": 0,
        "delegateResignation": 0
      }
    },
    "ignoreInvalidSecondSignatureField": true,
    "vendorFieldLength": 64
  },
  {
    "height": 10800,
    "reward": 200000000
  },
  {
    "height": 21600,
    "block": {
      "maxTransactions": 150,
      "maxPayload": 6300000
    }
  },
  {
    "height": 910000,
    "block": {
      "maxTransactions": 500,
      "maxPayload": 21000000
    }
  },
  {
    "height": 950000,
    "ignoreInvalidSecondSignatureField": false
  },
  {
    "height": 1750000,
    "vendorFieldLength": 255
  },
  {
    "height": 1895000,
    "block": {
      "idFullSha256": true
    }
  }
]
```

The first element in this array is the milestone that will kick in when you start network at height 1 with the genesis block, all other milestones will be merged into this one and overwrite existing properties or add new ones you specify in later milestones.

For example you can see that the `reward` is configured as `0` at height `1` which means blocks will be forged without any rewards for the delegates but the next milestone at height `10800` shows a reward property with a value of `200000000` which equals `2 ARK` in our case.

As soon as the network reaches height `10800` it expects all blocks to be broadcasted with a reward of `200000000` and will no longer accept blocks that specify `0` as their reward which will result in a hard-fork for everyone that does not update as they will be unable to accept incoming blocks.

## How Do I Modify or Add Properties? <a id="how-do-i-modify-or-add-properties"></a>

Adding or modifying properties is as easy as adding a new object with the key-value pairs that you would like to add to previous milestone or overwrite. The next few examples should give you an idea about how simple it is to modify your milestones to change the behaviour and expectations of your network.

### Changing the Forging Rewards at a Specific Height <a id="changing-the-forging-rewards-at-a-specific-height"></a>

```javascript
[
  {
    "height": 1,
    "reward": 0,
    "activeDelegates": 51,
    "blocktime": 8,
    "block": {
      "version": 0,
      "maxTransactions": 50,
      "maxPayload": 2097152
    },
    "epoch": "2017-03-21T13:00:00.000Z",
    "fees": {
      "staticFees": {
        "transfer": 10000000,
        "secondSignature": 500000000,
        "delegateRegistration": 2500000000,
        "vote": 100000000,
        "multiSignature": 500000000,
        "ipfs": 0,
        "timelockTransfer": 0,
        "multiPayment": 0,
        "delegateResignation": 0
      }
    },
    "ignoreInvalidSecondSignatureField": true,
    "vendorFieldLength": 64
  },
  {
    "height": 10800,   // The reward changes at block height 10800 to the specified value
    "reward": 200000000
  }
]
```

### Changing the Number of Delegates \(Block Producers\) <a id="changing-the-number-of-delegates-block-producers"></a>

```javascript
[
  {
    "height": 1,
    "reward": 0,
    "activeDelegates": 51,
    "blocktime": 8,
    "block": {
      "version": 0,
      "maxTransactions": 50,
      "maxPayload": 2097152
    },
    "epoch": "2017-03-21T13:00:00.000Z",
    "fees": {
      "staticFees": {
        "transfer": 10000000,
        "secondSignature": 500000000,
        "delegateRegistration": 2500000000,
        "vote": 100000000,
        "multiSignature": 500000000,
        "ipfs": 0,
        "timelockTransfer": 0,
        "multiPayment": 0,
        "delegateResignation": 0
      }
    },
    "ignoreInvalidSecondSignatureField": true,
    "vendorFieldLength": 64
  },
  {
    "height": 10800,  // Changing the number of delegates at height 10800 to 102
    "activeDelegates": 102
  }
]
```

### Changing the Number of a Transactions a Block Can Hold <a id="changing-the-number-of-a-transactions-a-block-can-hold"></a>

```javascript
  {
    "height": 1,
    "reward": 0,
    "activeDelegates": 51,
    "blocktime": 8,
    "block": {
      "version": 0,
      "maxTransactions": 50,
      "maxPayload": 2097152
    },
    "epoch": "2017-03-21T13:00:00.000Z",
    "fees": {
      "staticFees": {
        "transfer": 10000000,
        "secondSignature": 500000000,
        "delegateRegistration": 2500000000,
        "vote": 100000000,
        "multiSignature": 500000000,
        "ipfs": 0,
        "timelockTransfer": 0,
        "multiPayment": 0,
        "delegateResignation": 0
      }
    },
    "ignoreInvalidSecondSignatureField": true,
    "vendorFieldLength": 64
  },
  {
    "height": 10800,
    "block": { // setting new block values and limitations
      "maxTransactions": 150,
      "maxPayload": 6300000
    }
  }
]
```

### Changing the Length of the Vendor Field <a id="changing-the-length-of-the-vendor-field-smart-bridge"></a>

```javascript
[
  {
    "height": 1,
    "reward": 0,
    "activeDelegates": 51,
    "blocktime": 8,
    "block": {
      "version": 0,
      "maxTransactions": 50,
      "maxPayload": 2097152
    },
    "epoch": "2017-03-21T13:00:00.000Z",
    "fees": {
      "staticFees": {
        "transfer": 10000000,
        "secondSignature": 500000000,
        "delegateRegistration": 2500000000,
        "vote": 100000000,
        "multiSignature": 500000000,
        "ipfs": 0,
        "timelockTransfer": 0,
        "multiPayment": 0,
        "delegateResignation": 0
      }
    },
    "ignoreInvalidSecondSignatureField": true,
    "vendorFieldLength": 64
  },
  {
    "height": 10800,
    "vendorFieldLength": 512
  }
]
```

### Changing the Time in Seconds to Produce and Broadcast Blocks <a id="changing-the-time-in-seconds-to-produce-and-broadcast-blocks"></a>

```javascript
[
  {
    "height": 1,
    "reward": 0,
    "activeDelegates": 51,
    "blocktime": 8,
    "block": {
      "version": 0,
      "maxTransactions": 50,
      "maxPayload": 2097152
    },
    "epoch": "2017-03-21T13:00:00.000Z",
    "fees": {
      "staticFees": {
        "transfer": 10000000,
        "secondSignature": 500000000,
        "delegateRegistration": 2500000000,
        "vote": 100000000,
        "multiSignature": 500000000,
        "ipfs": 0,
        "timelockTransfer": 0,
        "multiPayment": 0,
        "delegateResignation": 0
      }
    },
    "ignoreInvalidSecondSignatureField": true,
    "vendorFieldLength": 64
  },
  {
    "height": 10800, // increasing block time to 30s from height 10800 onwards
    "blocktime": 30
  }
]
```

### Adding Static Fees for New Transaction Types <a id="adding-static-fees-for-new-transaction-types"></a>

```javascript
[
  {
    "height": 1,
    "reward": 0,
    "activeDelegates": 51,
    "blocktime": 8,
    "block": {
      "version": 0,
      "maxTransactions": 50,
      "maxPayload": 2097152
    },
    "epoch": "2017-03-21T13:00:00.000Z",
    "fees": {
      "staticFees": {
        "transfer": 10000000,
        "secondSignature": 500000000,
        "delegateRegistration": 2500000000,
        "vote": 100000000,
        "multiSignature": 500000000,
        "ipfs": 0,
        "timelockTransfer": 0,
        "multiPayment": 0,
        "delegateResignation": 0
      }
    },
    "ignoreInvalidSecondSignatureField": true,
    "vendorFieldLength": 64
  },
  {
    "height": 10800,
    "fees": {
      "staticFees": {
        "newTransactionType": 10000000
      }
    }
  }
]
```

**These are just a few examples of how you can modify existing milestone properties or add new ones.**

{% hint style="danger" %}
Whenever you are adding new properties, make sure that your code is able to handle undefined values when a network starts from 0. The easiest way of doing this is to set an initial value in your genesis milestone **\(height 1\)** to not require any extra checks in your code.
{% endhint %}

