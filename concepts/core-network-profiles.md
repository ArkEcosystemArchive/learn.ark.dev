---
description: >-
  Explanation of Core Network Profiles Terminology In Relation To Development
  Process
---

# Network Profiles

{% hint style="warning" %}
It is recommended to start developing with a Testnet network, as you need to become familiar with the installation of your bridgechain and how the network operates. You don't need to depend on a server network of peers, as it simulates them on your local machine, so you can focus on the development process.
{% endhint %}

## Mainnet

is the network you will be running in production, and it is the backbone of your project. This is usually known as the _Public Network_ since this network is utilized by your end users. This network is _real coins, real transactions_.

## Devnet

is the network where testing occurs before being deployed on the Mainnet. In this _Development Network_, developers try to break things or test new features. If your project is open to community devs, they will be using this network to suggest and test network improvements. Be advised that due to the nature of blockchain and immutability, we strongly recommend that changes are tested on Devnet before you push them to live production on Mainnet. This network is _play-around coins and transactions._

## Testnet

is a _Testing Network_ that you usually run locally when testing and developing changes and don't expect to involve a wider audience. Running a Testnet means that you can run a blockchain on your local machine for development purposes. Changes you test here are usually pushed to Devnet for a wider audience. This network is _play-around coins and transactions._

## How Many Servers \(Peers\) Are Required To Run a Network 

The number of peers required for a functioning network changes depending on what type of network you are deploying:

* **Mainnet** requires a minimum of **20 peers** for a functioning network.
* **Devnet** requires a minimum of **5 peers** for a functioning network.
* **Testnet** is to be used in an instance where only the genesis node is utilized for testing purposes. **No peers are required**.

The number of peers required for a functioning network changes depending on what type of network you are deploying:



