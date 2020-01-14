---
description: >-
  This class implements the builder pattern. We use it to build and sign
  transaction payload.
---

# Implement Transaction Builder

Builder class handles versioning, serde process, milestones, dynamic-fee logic and _all cryptography related items_ \(sign, multisign, second-sign, sign with and without WIF, nonce logic\). The following code-snippet shows the actual i[mplementation of the **Builder**](https://github.com/learn-ark/dapp-custom-transaction-example/blob/master/src/builders/BusinessRegistrationBuilder.ts#L4) class for the BusinessRegistration Transaction.

```typescript
import { Interfaces, Transactions, Utils } from "@arkecosystem/crypto";
import { BusinessRegistrationTransaction } from "../transactions";

export class BusinessRegistrationBuilder extends Transactions.TransactionBuilder<BusinessRegistrationBuilder> {
    constructor() {
        super();
        this.data.type = BusinessRegistrationTransaction.type;
        this.data.typeGroup = BusinessRegistrationTransaction.typeGroup;
        this.data.version = 2;
        this.data.fee = Utils.BigNumber.make("5000000000");
        this.data.amount = Utils.BigNumber.ZERO;
        this.data.asset = { businessData: {} };
    }

    public businessData(name: string, website: string): BusinessRegistrationBuilder {
        this.data.asset.businessData = {
            name,
            website,
        };

        return this;
    }

    public getStruct(): Interfaces.ITransactionData {
        const struct: Interfaces.ITransactionData = super.getStruct();
        struct.amount = this.data.amount;
        struct.asset = this.data.asset;
        return struct;
    }

    protected instance(): BusinessRegistrationBuilder {
        return this;
    }
}

```

Now that we have implemented our builder class, we can use it to build new custom transaction payloads. The [code snippet](https://github.com/learn-ark/dapp-custom-transaction-example/blob/master/__tests__/test.test.ts#L13-L17) below shows us how to use the TransactionBuilder to create signed and serialized transaction payloads. 

```typescript
const builder = new BusinessRegistrationBuilder();
const actual = builder
    .nonce("3")
    .fee("100")
    .businessAsset("google","www.google.com")
    .sign("clay harbor enemy utility margin pretty hub comic piece aerobic umbrella acquire");
console.log(actual.build().toJson());
```

Next step is to implement transaction handlers that enforce blockchain protocol validation and verification steps.

