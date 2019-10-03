# Common Terms

## Account

An account is a pair of private and public key, represented as a single address. In blockchain networks, accounts can refer to many things, such as a user, wallet or contract identity. An account is more like a record which the network participants maintain to track the network state.

On the ARK blockchain, an account is used to keep track of sent and received transactions \(transfers, votes, multisignatures, second signatures, delegate registration and eventually many more\). The account owner can issue an outgoing transaction with the use of his secret phrase or receive funds by having another user send a transaction from their account to the receiver's account address.

In the Bitcoin network, by contrast, the account is an evolving collection of keys which represent unspent coins that can be used for outgoing transfers \([UTXO](https://en.wikipedia.org/wiki/Unspent_transaction_output)\).

## Block

A block is a collection of transactions, but also it is the incremental unit of the blockchain. Every eight seconds, a Delegate Node \(A forger\) creates \(forges\) a new block by bundling a bunch of transactions, verifying each transaction, and signing the block.

Blocks hold quite a lot of metadata on the ARK blockchain, like:

* Height, an incremental ID.
* Timestamp.
* Transactions.
* Creator's signature.
* Total transfer amount.
* Total fee amount.

These are a few examples of relevant information which blocks are required to hold for the network's stability.

## Delegate

A delegate’s role first and foremost is to secure the network. To gain community support however, delegates must also differentiate themselves. In addition to running nodes and securing the network, mainnet delegates often pledge to offer various services including development and testing, public resources and tools utilizing the mainnet, faucets, bounty programs, outreach, art, games, media creation, events, research, and more.   
  
A delegate is an account, or account owner, who has registered as one on the blockchain with the use of a delegate registration transaction.

Delegated block production is an advantage for a blockchain. It allows for seamless processing of blocks because the delegates are incentivized, through monetary reward, to maintain their voters' pledges by acting appropriately.

## Peer

Every ARK node maintains a registry of other full nodes, referred to as _peers_. At a minimum, a peer must expose its p2p API, but most also expose a Public API.

## Node

A node is a functional participant running the Core Server in the distributed network. At a minimum, a node holds a complete copy of the blockchain, allowing it to validate blocks and transactions autonomously. Currently, there is only one implementation of an ARK node, the official [ARK Core](https://https//github.com/arkecosystem/core).

Nodes are further divided into two categories: Delegate/Forger Nodes, of which 51 exist and maintain consensus, and Relay Nodes, which do validate transactions and blogs, but refrain from creating blocks.

## Signature

A signature is the product of a cryptographic one-way hashing function which allows a lightweight and secure way to determine the authenticity and integrity of a message. In the case of blockchain networks, messages mainly refer to transactions and their payloads \(SmartBridge for ARK\) or blocks.

Signatures are necessary to prove that a block or transaction was forged or created by the owner of the secret passphrase linked to the public facing identity of the user.

## Transaction

A transaction is an atomic change in the state of the blockchain. The simplest form transfers value from address A to B, incorporating a fee for the processing Delegate Node. Transactions are bundled into a block. At that moment they are committed to the blockchain and become irreversible.

## Reward

Once every 8 seconds, when a block is forged, the fees for every transaction and two ARK is awarded to the forging delegate. The block reward is important to provide an economic incentive for delegates to remain in the top 51.

## Fee

On the ARK blockchain and similar Bridgechains, fees are charged based on the type of transaction sent. A flat fee can be charged for every transfer of ARK from one address to another or when performing transactions such as delegate registrations, second signature registrations, multisignature registrations, etc.

With The Core Server, a new dynamic fee structure is implemented. The new structure allows for delegates, who are responsible for forging blocks from transactions, to set their own fees on a transaction type basis. This means that your transaction can cost more or less in fees for it to be included into a block and then the blockchain. Dynamic fees are based on the total size of the transaction in bytes. Dynamic means that the delegates set their acceptance fees for transaction inclusion during the block creation process.

## Height

A blockchains height is the total number of blocks forged; where the genesis block is either height 0 or height 1: just a regular incremental ID. Timestamps cannot be wholly trusted in distributed ledgers, but the height can.

## Missed Block

Sometimes, a delegate can have problems with their responsibility to forge a block when their time comes to do so.

When a delegate doesn't forge and broadcasts a block within the time slot allocated, their productivity decreases. Delegates with lower productivity typically lose voters when they begin missing many blocks.

## ARKtoshi

ARKtoshi = 0.00000001 ARK

## BridgeChain

Code forks of the ARK blockchain aiming to be interoperable with ARK. 

## AIPs, ARK Improvement Proposals

A curated list of improvement proposals. Breaking changes are first formulated as AIPs, discussed and reviewed by the community before being implemented.

## Transaction Pool

The transaction pool is an in-memory data store that holds transactions before forging. All transactions are saved in this pool alongside the following metadata:

* the insertion sequence, or when the transaction was added relative to the others in the pool
* the pingCount, or the count of how many times this ARK Core node has received this transaction from its peers

Before a transaction is added to the pool, a "pool charge" is made against the sending account. This transaction is not applied in full until the transaction is included in a block, and is reverted should the transaction drop out of the pool for any reason. The point of the "pool charge" is to preemptively apply the transaction's effects to the account in question so that another transaction can not spend that value. This minimizes the possibility of a double spend, as the transaction pool will reject transactions that spend the same value twice.

All nodes broadcast the transactions they receive to their peers through the P2P API. Thus, as your transaction awaits forging, it will be joined in the pool by other uncommitted transactions from across the network.

When deciding on which transactions to include in the block, the transaction pool considers two factors: **fee value** and **pool insertion** time. The pool prefers transactions with higher fees and decides between transactions with similar fees by comparing their insertion sequence numbers. These considerations may be configured as described in [dynamic fees](https://docs.ark.io/tutorials/node/dynamic-fees.html).

## Transactions Serialization Process <a id="serialize"></a>

All transactions are serialized and signed on client applications prior to submission to Core Server nodes. Every Crypto SDK includes functionality for serializing transactions from raw data into the binary transaction format supported across the ARK blockchain topology. Look for a `builder` module within your chosen SDK that contains methods to chain data onto the transaction type of your choice. To learn more about serialization and specific transaction types look into this document:

{% page-ref page="../concepts/transaction-types.md" %}

{% hint style="danger" %}
No node will accept a transaction without a valid signature from a private key. Make sure you invoke the SDK builder's `sign` method on your transaction object using the sender's private key.
{% endhint %}





