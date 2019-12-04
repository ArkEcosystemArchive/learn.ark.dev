# How To Create API Servers

A common use-case for a module is that you process some data from within core and want to make use of that data with an external application. The easiest way to do this is through an HTTP server that exposes an API from which you request the data.

{% hint style="info" %}
Core provides a package called [core-http-utils](https://github.com/ARKEcosystem/core/tree/develop/packages/core-http-utils/src) which provides everything you will need to run an HTTP server with modules. Core uses [hapi](https://hapijs.com/) for all its HTTP based services as it enables developers to focus on writing reusable application logic instead of spending time building infrastructure.
{% endhint %}

## Step 0: New Module Setup <a id="installing-dependencies"></a>

To create a new module from a template follow this simple guide:

{% page-ref page="how-to-write-core-modules/setting-up-your-first-module.md" %}

After you have created the module and adjusted basic properties \(name, structure, dependencies\) we can start to add custom functionalities, like **adding a HTTP server.**

{% hint style="info" %}
**You can use our template project with HTTP server implementation already done**. Head over to [https://github.com/learn-ark/dapp-core-module-http-server-template](https://github.com/learn-ark/dapp-core-module-http-server-template) **** and create a new module from it.
{% endhint %}

Your new module will already have a running HTTP server implemented, so all you need to do is add your own routes and load the module in correct network configuration as defined in Step 3 below.

**Steps 1 and 2** are basic explanation of needed packages and implementation decisions to make the HTTP server working in line with the ARK Core best practices.

## Step 1: Adding core-http-utils Dependency <a id="installing-dependencies"></a>

As you've learned in [How to write a Core Modules](how-to-write-core-modules/) you will need to install the required dependencies. For our example we will use we need the **core-http-utils** package which you can install with the following command:

```bash
cd your-module-folder
lerna add @arkecosystem/core-http-utils --scope=@vendor/demo-plugin
```

 This will add a `core-http-utils` package dependency to our module.

## Step 2: Implement a HTTP Server Inside dApp Module <a id="creating-our-server"></a>

Now that `core-http-utils` is installed we can get started with starting our HTTP server, which is fairly simple.

This example will register a server with a single endpoint at `http://localhost:5003/` where `localhost` is the host and `5003` the port. When you run `curl http://localhost:5003/` you should get `Hello World` as response.

To create our server we need to import the following packages from `core-http-utils`:

```typescript
import { createServer, mountServer } from "@arkecosystem/core-http-utils";
import Hapi from "@hapi/hapi";
```

To start the server with predefined configuration we call the `createServer` and `mountServer` methods.

```typescript
await createServer(options);
await Server.registerRoutes("HTTP", this.http);
await mountServer(`Custom HTTP Public ${name.toUpperCase()} API`, server);
```

Below is the whole `server.ts` file that handles the creation and mounting logic and `plugin.ts` that starts/stops the HTTP server. Looking at the tabs, you can see the full implementation of the custom HTTP server logic and how it relates to the overall dApp creation module logic. Also note the `registerRoutes` method where you can custom routes.

{% tabs %}
{% tab title="plugin.ts" %}
```typescript
import { Container, Logger } from "@arkecosystem/core-interfaces";
import { defaults } from "./defaults";
import { Server } from "./server";

export const plugin: Container.IPluginDescriptor = {
    pkg: require("../package.json"),
    defaults,
    alias: "core-custom-server-example",
    async register(container: Container.IContainer, options) {
        container.resolvePlugin<Logger.ILogger>("logger").info("Starting dApp");

        const server = new Server(options);
        await server.start();

        return server;
    },

    async deregister(container: Container.IContainer, options) {
        await container.resolvePlugin<Server>("core-custom-server-example").stop();
    },
};

```
{% endtab %}

{% tab title="defaults" %}
```typescript
export const defaults = {
    enabled: true,
    host: "0.0.0.0",
    port: 5003,
};
```
{% endtab %}

{% tab title="server.ts" %}
```typescript
export class Server {
    private logger = app.resolvePlugin<Logger.ILogger>("logger");

    private http: any;

    public constructor(private readonly config: any) {
        this.config = config;
    }

    public async start(): Promise<void> {
        const options = {
            host: this.config.host,
            port: this.config.port,
        };

        if (this.config.enabled) {
            this.http = await createServer(options);
            this.http.app.config = this.config;

            await Server.registerRoutes("HTTP", this.http);
        }

        // TODO: add SSL support. See plugin `core/packages/core-api` for more information
    }

    public async stop(): Promise<void> {
        if (this.http) {
            this.logger.info(`Stopping Custom HTTP Server`);
            await this.http.stop();
        }
    }

    public async restart(): Promise<void> {
        if (this.http) {
            await this.http.stop();
            await this.http.start();
        }
    }

    public instance(type: string): Hapi.Server {
        return this[type];
    }

    private static async registerRoutes(name: string, server: Hapi.Server): Promise<void> {
        server.route({
            method: "GET",
            path: "/",
            handler() {
                return { data: "Hello ARKies!" };
            },
        });

        await mountServer(`Custom HTTP Public ${name.toUpperCase()} API`, server);
    }
}

```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
Head over to: [https://github.com/learn-ark/dapp-core-module-http-server-template](https://github.com/learn-ark/dapp-core-module-http-server-template) and create a new module. Your new module will already have a running HTTP server implemented, so all you need to do is add your own routes and load the module in correct network configuration.
{% endhint %}

### **Route Handlers And Best Practices**

Adding more routes and handlers would make code unreadable. That is why we must split the logic into route registrations and implementations. The file `handlers.ts` inside the template module servers as an example on how to achieve this. For example we register a route in the `server.ts` with this line:

```typescript
// source: https://github.com/learn-ark/dapp-core-module-http-server-template/blob/master/src/server.ts#L63
server.route([{ method: "GET", path: "/config", ...handlers.config }]);
```

The above route is implemented with a simple `handler.ts` file:

```typescript
import { app } from "@arkecosystem/core-container";
import { Plugins } from "@arkecosystem/core-utils";

export const config = {
    async handler() {
        const appConfig = app.getConfig();

        return {
            data: {
                version: app.getVersion(),
                network: {
                    version: appConfig.get("network.pubKeyHash"),
                    name: appConfig.get("network.name"),
                    nethash: appConfig.get("network.nethash"),
                    explorer: appConfig.get("network.client.explorer"),
                    token: {
                        name: appConfig.get("network.client.token"),
                        symbol: appConfig.get("network.client.symbol"),
                    },
                },
                plugins: Plugins.transformPlugins(appConfig.config.plugins),
            },
        };
    },
    config: {
        cors: true,
    },
};
```

By using this approach it is much easier to split and manage your API code. Also check our official `core-api` plugin to learn more about our API and best practices.

## Step 3: Load The Module Within Network Configuration <a id="creating-our-server"></a>

We already learned how to load the new module within selected network configuration. All we have to do is edit the `plugin.js` file and add our new module name to the list. 

### **Step 3.1: Load the new module in plugins.js**

Go [here](https://learn.ark.dev/application-development/how-to-write-core-modules/setting-up-your-first-module#step-2-module-registration-within-network-configuration) for detailed explanation on how to achieve this. ****

### **Step 3.2: Start you local Testnet**

Now Start You Local Testnet Blockchain with the new module enabled by following [this guide](https://learn.ark.dev/application-development/how-to-write-core-modules/setting-up-your-first-module#step-3-running-your-dapp)!

