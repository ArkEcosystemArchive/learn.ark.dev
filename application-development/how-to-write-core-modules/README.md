---
description: Learning the building blocks of ARK Core dApps
---

# How To Write Core Modules

ARK Core has an extensive and powerful plugin system that allows you to very easily break your application up into isolated pieces of business logic, and reusable utilities - **modules**. Modular structure enables developers to focus on writing reusable application logic instead of spending time thinking about software architecture.

{% hint style="info" %}
Modules are the core building blocks of our blockchain development framework. Modular structure enables us to build distributed applications and introduce new custom build transaction types. **It is essential for you to understand and master the art of ARK core module development.** 
{% endhint %}

Everything you will built will be packaged as a core module. That will also enable you to separate your code from our core blockchain platform, meaning updates and migration will be almost zero-configuration and effort. To learn more about modules structure and how to write them follow the links below:

{% page-ref page="basic-structure-and-properties.md" %}

{% page-ref page="setting-up-your-first-module.md" %}

## Reusable dApp Module Templates

We provide module templates, that enable you to skip the boilerplate code generation and give you an implementation head start. The following templates are available:

{% embed url="https://github.com/learn-ark/dapp-core-module-template" caption="Basic dApp Core Module Template" %}

{% embed url="https://github.com/learn-ark/dapp-core-module-http-server-template" caption="Core Module Template with HTTP Server Implemented" %}

{% embed url="https://github.com/learn-ark/dapp-core-module-gti-template" caption="Core Module Template With Custom Transaction Implementation Skeleton" %}

{% hint style="info" %}
Every template is based on the Basic Core Module Template with additional implementation. **You can add ANY kind of programming logic to your module implementation.**
{% endhint %}

