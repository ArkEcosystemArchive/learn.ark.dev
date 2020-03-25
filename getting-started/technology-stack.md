---
description: This page describes the tools and technologies we use daily
---

# Technology Stack

As a team of people using technology to make DLT products, it's essential to be unambiguous about the technology/tools we use, so that everyone is clear what we all need to learn/use to make product\(s\) that are functional, fast, beautiful, usable and reliable!

ARK Core is written in [TypeScript](https://github.com/microsoft/typescript), and it has been using [Lerna](https://github.com/lerna/lerna) to manage the development and publication of its packages and uses [Node.js](https://nodejs.org) as execution environment. 

Read and understand the key concepts explaining transaction types, cryptography, blockchain protocol, core server/node running modes and more, by following the link below.

{% page-ref page="core-fundamentals.md" %}

## Technology Stack 

The following development tools need to be installed on your machine to develop an application using ARK Core:

* [NodeJS](https://nodejs.org/en/) - As ARK Core is written exclusively in NodeJS, the server-side framework for JavaScript, installing Node is a necessity for core development.
* [Hapi.js](https://hapi.dev/) - A rich web framework for building applications and services. A base for our public REST API.
* [SocketCluster.io](https://socketcluster.io/#!/) - SocketCluster is an open source real-time framework for Node.js. It supports both direct client-server communication and group communication via pub/sub channels. It is designed to easily scale to any number of processes/hosts. We use SocketCluster for the peer-to-peer communication enabling the blockchain protocol.
* [PostgreSQL](https://www.postgresql.org/) - our "standard" database is Postgres. Postgres is the most "mature" Open Source Relational Database. It's 100% Free \(including all "advanced" features\).
* [Lerna.js](https://lerna.js.org/) - A tool for managing JavaScript projects with multiple packages.
* [TypeScript](https://github.com/microsoft/typescript) -  A language for application-scale of JavaScript. TypeScript adds optional types to JavaScript that support tools for large-scale JavaScript applications for any browser, for any host, on any OS. TypeScript compiles to readable, standards-based JavaScript.

## Operating System

While we have a strong preference for **Ubuntu** **Linux** we know that both Node.js and Postgres run on almost any environment including Microsoft Windows Desktop & Server. 

{% hint style="info" %}
**All production and support tools are developed for Ubuntu Linux operating systems**. We do not support Windows environment operating system in production. However it is still possible to develop your applications on a windows box.
{% endhint %}

