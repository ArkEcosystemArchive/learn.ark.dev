---
description: >-
  This section provides an overview of Mainnet supported transaction types and
  their structure.
---

# Transaction Types

## Introduction

This sections describes mainnet transaction types and its structure related to `serde` process \([serialization and deserialization of transactions](../terminology.md#serialize)\).

{% hint style="info" %}
Transactions are the heart of any blockchain, cryptocurrency or otherwise. They represent a transfer of value from one network participant to another. In ARK, transactions can be of one of multiple types, specified in AIP11, which can affect the content and data structure of each transaction's payload.
{% endhint %}

Using[ ARK SDKs](https://sdk.ark.dev), developers can employ the programming language of their choice to build applications utilizing the ARK blockchain. The ARK SDKs are split into two packages for each language: Client and Cryptography.

**Client** SDKs help developers fetch information from the ARK blockchain about its current state: which delegates are currently forging, what transactions are associated with a given wallet, and so on.

**Cryptography** SDKs, by contrast, assist developers in working with transactions: signing, serializing, deserializing, etc.

For more information about SDK implementations visit [ARK SDKs hub](https://sdk.ark.dev/).

In the following sections basic transaction types and their structure is presented. If you are interested in the signature generation process and algorithm used, please check the [Cryptography Overview](../cryptography.md) page.

### List of Transaction Types:

{% page-ref page="transfer.md" %}

{% page-ref page="second-signature-registration.md" %}

{% page-ref page="delegate-registration.md" %}

{% page-ref page="vote-and-unvote-transaction.md" %}

{% page-ref page="multisignature-transaction.md" %}

{% page-ref page="ipfs-transaction.md" %}

{% page-ref page="multipayment-transaction.md" %}

{% page-ref page="delegate-resignation.md" %}

{% page-ref page="hashed-time-locked-contracts.md" %}

