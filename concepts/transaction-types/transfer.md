---
description: Transfer Transaction Type Specifications
---

# Transfer

The transfer transaction enables a user to broadcast a transaction to the network sending ARK tokens from one ARK wallet to another. This transaction type provides the utility of store-of-value and value transfer. It also contains a special data field of 255 bytes called the vendor field, allowing raw data, code or plain text to be stored on the blockchain. The vendor field is public and immutable, and is also utilized in ARK SmartBridge Technology

| References |  |
| :--- | :--- |
| ARK Improvement Proposals | [AIP11](https://github.com/ArkEcosystem/AIPs/blob/master/AIPS/aip-11.md), [AIP29](https://github.com/ArkEcosystem/AIPs/blob/master/AIPS/aip-29.md) |
| API Endpoints | [Link](https://api.ark.dev/public-rest-api/endpoints/transactions) |
| AJV Schema | [Base](https://github.com/ArkEcosystem/core/blob/master/packages/crypto/src/transactions/types/schemas.ts#L16) \| [Transfer](https://github.com/ArkEcosystem/core/blob/master/packages/crypto/src/transactions/types/schemas.ts#L59) |

### Transaction Structure Without VendorField

#### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 0,
    "nonce": "1",
    "senderPublicKey": "03a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933",
    "fee": "10000000",
    "amount": "100000",
    "expiration": 0,
    "recipientId": "AJWRd23HNEhPLkK1ymMnwnDBX2a7QBZqff",
    "signature": "4f01bd21828a633a3c821b9984fe642deab87237b99e62a543ca6948ff1d6d32f2475ada1f933da0591c40603693614afa69fcb4caa2b4be018788de9f10c42a",
    "id": "8c85167cb1ca6f70e350f30173deb4c0a00ce7169d04f78fe4e4bcf2c3a75214"
}
```

#### Serialized Payload

```text
ff0217010000000000010000000000000003a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933809698000000000000a08601000000000000000000171dfc69b54c7fe901e91d5a9ab78388645e2427ea4f01bd21828a633a3c821b9984fe642deab87237b99e62a543ca6948ff1d6d32f2475ada1f933da0591c40603693614afa69fcb4caa2b4be018788de9f10c42a
```

#### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0000` |
| **Nonce:** | **\[9\]** | **8** | `0x0100000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x03a02b9d5fdd1307c2ee4652ba54d492d1fd11a7d1bb3f3a44c4a05e79f19de933` |
| **Fee:** | **\[50\]** | **8** | `0x8096980000000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Amount:** | **\[59\]** | **8** | `0xa086010000000000` |
| **Expiration:** | **\[67\]** | **4** | `0x00000000` |
| **Recipient:** | **\[71\]** | **21** | `0x171dfc69b54c7fe901e91d5a9ab78388645e2427ea` |
| **Signature:** | **\[92\]** | **64** | `0x4f01bd21828a633a3c821b9984fe642deab87237b99e62a543ca6948ff1d6d32f2475ada1f933da0591c40603693614afa69fcb4caa2b4be018788de9f10c42a` |

### Transaction Structure With VendorField

#### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 0,
    "nonce": "2",
    "senderPublicKey": "03d59f3b7d698536f6925a77f22d484d518b06a2c09318e8e5ff487afcdedefb2c",
    "fee": "10000000",
    "amount": "1",
    "vendorFieldHex": "302e3132373131363230373030383934323434",
    "vendorField": "0.12711620700894244",
    "expiration": 0,
    "recipientId": "AUbLwNEQWMshw4vBGYyR8JWn4Lx6sJbj6M",
    "signature": "504215bf61f7e8e0d4cd7c7e1511b501367e8c2f3543972906a3b80d42cebc3e4ec974f938124661cb65eab93dacba6ba0f5045861ac28fc0287462557ffd99b",
    "id": "8bd461006dc6481c17b38f652e775d151fb36e8b3f390fb213b6b5c399df6c97"
}
```

#### Serialized Payload

```text
ff0217010000000000020000000000000003d59f3b7d698536f6925a77f22d484d518b06a2c09318e8e5ff487afcdedefb2c809698000000000013302e3132373131363230373030383934323434010000000000000000000000178c9bd74222025a19063c8fca8a50c39a891feeca504215bf61f7e8e0d4cd7c7e1511b501367e8c2f3543972906a3b80d42cebc3e4ec974f938124661cb65eab93dacba6ba0f5045861ac28fc0287462557ffd99b
```

#### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0000` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x03d59f3b7d698536f6925a77f22d484d518b06a2c09318e8e5ff487afcdedefb2c` |
| **Fee:** | **\[50\]** | **8** | `0x8096980000000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x13` |
| **VendorField:** | **\[59\]** | **19** | `0x302e3132373131363230373030383934323434` |
| **Amount:** | **\[78\]** | **8** | `0x0100000000000000` |
| **Expiration:** | **\[86\]** | **4** | `0x00000000` |
| **Recipient:** | **\[90\]** | **21** | `0x178c9bd74222025a19063c8fca8a50c39a891feeca` |
| **Signature:** | **\[111\]** | **64** | `0x504215bf61f7e8e0d4cd7c7e1511b501367e8c2f3543972906a3b80d42cebc3e4ec974f938124661cb65eab93dacba6ba0f5045861ac28fc0287462557ffd99b` |

## 

