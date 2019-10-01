---
description: >-
  This section provides an overview of Mainnet supported transaction types and
  their detailed structure.
---

# Transaction Types Structure

## Introduction

This sections describes mainnet transaction types and its structure related to `serde` process \(serialization and deserialization of transactions\).

Transactions are the heart of any blockchain, cryptocurrency or otherwise. They represent a transfer of value from one network participant to another. In ARK, transactions can be of one of multiple types, specified in AIP11, which can affect the content and data structure of each transaction's payload.

Using[ ARK SDKs](https://sdk.ark.dev), developers can employ the programming language of their choice to build applications utilizing the ARK blockchain. The ARK SDKs are split into two packages for each language: Client and Cryptography.

**Client** SDKs help developers fetch information from the ARK blockchain about its current state: which delegates are currently forging, what transactions are associated with a given wallet, and so on.

**Cryptography** SDKs, by contrast, assist developers in working with transactions: signing, serializing, deserializing, etc. 

For more information about SDK implementations visit [ARK SDKs hub](https://sdk.ark.dev/). 

In the following sections basic transaction types and their structure is presented. If you are interested in the signature generation process and algorithm used, please check the [Cryptography Overview](cryptography.md) page.

## Transfer Transaction Type

### Signed JSON Payload

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

### Serialized Payload

```text
ff0217010000000000020000000000000003d59f3b7d698536f6925a77f22d484d518b06a2c09318e8e5ff487afcdedefb2c809698000000000013302e3132373131363230373030383934323434010000000000000000000000178c9bd74222025a19063c8fca8a50c39a891feeca504215bf61f7e8e0d4cd7c7e1511b501367e8c2f3543972906a3b80d42cebc3e4ec974f938124661cb65eab93dacba6ba0f5045861ac28fc0287462557ffd99b
```

### Deserialized Hex Payload

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

## Second Signature Registration



### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 1,
    "nonce": "2",
    "senderPublicKey": "02e0c063777427ac196af3c426fd648231ebc4ea06fff5edb1652b98f9c8420c69",
    "fee": "500000000",
    "amount": "0",
    "asset": {
        "signature": {
            "publicKey": "02877e4f35c76abaeb152b128670db0a7ae10b3999afcd28a42938b653fbf87ae9"
        }
    },
    "signature": "adb983dd28827860f69c6a98b2f9db88a9e084cc7fe3a691463377c3225b02fee24547b516d1cf05f2f77b65a9c36069f6540605c01694008e2a5cb4fc88f62f",
    "id": "4c2cd8c4281a34a60505f260d067e5c678d3c57510bfbcda24c5e0da5f46bd5e"
}
```

### Serialized Payload

```text
ff0217010000000100020000000000000002e0c063777427ac196af3c426fd648231ebc4ea06fff5edb1652b98f9c8420c690065cd1d000000000002877e4f35c76abaeb152b128670db0a7ae10b3999afcd28a42938b653fbf87ae9adb983dd28827860f69c6a98b2f9db88a9e084cc7fe3a691463377c3225b02fee24547b516d1cf05f2f77b65a9c36069f6540605c01694008e2a5cb4fc88f62f
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0100` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x02e0c063777427ac196af3c426fd648231ebc4ea06fff5edb1652b98f9c8420c69` |
| **Fee:** | **\[50\]** | **8** | `0x0065cd1d00000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Second PublicKey:** | **\[59\]** | **8** | `0x02877e4f35c76abaeb152b128670db0a7ae10b3999afcd28a42938b653fbf87ae9` |
| **Signature:** | **\[67\]** | **64** | `0xadb983dd28827860f69c6a98b2f9db88a9e084cc7fe3a691463377c3225b02fee24547b516d1cf05f2f77b65a9c36069f6540605c01694008e2a5cb4fc88f62f` |

## Delegate Registration



### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 2,
    "nonce": "2",
    "senderPublicKey": "02a574b8995542631976691a7f73b59e4700cd84badb831331ab18ae2113a184ba",
    "fee": "2500000000",
    "amount": "0",
    "asset": {
        "delegate": {
            "username": "02a574b8995542631976"
        }
    },
    "signature": "f2cf8acf6ccb71fa0e848ca185a93e6ff44e0dd266b08c4bc0dfc7984499acd759f6067ace6bb00eae404eafa6af3548f5d35f8727f4ddeba69b6d925c604338",
    "id": "9b232e31c6385a2c730f5bec3c0220da6a184320e6c38bd7b6fd5a18b8501472"
}
```

### Serialized Payload

```text
ff0217010000000200020000000000000002a574b8995542631976691a7f73b59e4700cd84badb831331ab18ae2113a184ba00f902950000000000143032613537346238393935353432363331393736f2cf8acf6ccb71fa0e848ca185a93e6ff44e0dd266b08c4bc0dfc7984499acd759f6067ace6bb00eae404eafa6af3548f5d35f8727f4ddeba69b6d925c604338
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0200` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x02a574b8995542631976691a7f73b59e4700cd84badb831331ab18ae2113a184ba` |
| **Fee:** | **\[50\]** | **8** | `0x00f9029500000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Username Length:** | **\[59\]** | **1** | `0x14` |
| **Username:** | **\[60\]** | **20** | `0x3032613537346238393935353432363331393736` |
| **Signature:** | **\[80\]** | **64** | `0xf2cf8acf6ccb71fa0e848ca185a93e6ff44e0dd266b08c4bc0dfc7984499acd759f6067ace6bb00eae404eafa6af3548f5d35f8727f4ddeba69b6d925c604338` |

## Vote Transaction



### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 3,
    "nonce": "2",
    "senderPublicKey": "02555806bca6737eaeaff6434d5171bac8aeb72533ed9bafb280dd11b328a3822d",
    "fee": "100000000",
    "amount": "0",
    "asset": {
        "votes": [
            "+02555806bca6737eaeaff6434d5171bac8aeb72533ed9bafb280dd11b328a3822d"
        ]
    },
    "signature": "77a40e4b4170ce613c8f9ccc0650887349330a9a8b459189ee379c88cf2c8506d65aa3ca8293705373f1bde8d6b27e5071de1785ac9c0182f41e364f8f9e3b64",
    "id": "fd59eaa4a2bbb3570c7b01ad464c968aa9bf73a40e0417c802ab30553ded8476"
}
```

### Serialized Payload

```text
ff0217010000000300020000000000000002555806bca6737eaeaff6434d5171bac8aeb72533ed9bafb280dd11b328a3822d00e1f5050000000000010102555806bca6737eaeaff6434d5171bac8aeb72533ed9bafb280dd11b328a3822d77a40e4b4170ce613c8f9ccc0650887349330a9a8b459189ee379c88cf2c8506d65aa3ca8293705373f1bde8d6b27e5071de1785ac9c0182f41e364f8f9e3b64
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0300` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x02555806bca6737eaeaff6434d5171bac8aeb72533ed9bafb280dd11b328a3822d` |
| **Fee:** | **\[50\]** | **8** | `0x00e1f50500000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Number of Votes:** | **\[59\]** | **1** | `0x01` |
| **Vote:** | **\[60\]** | **34** | `0x0102555806bca6737eaeaff6434d5171bac8aeb72533ed9bafb280dd11b328a3822d` |
| **Signature:** | **\[94\]** | **64** | `0x77a40e4b4170ce613c8f9ccc0650887349330a9a8b459189ee379c88cf2c8506d65aa3ca8293705373f1bde8d6b27e5071de1785ac9c0182f41e364f8f9e3b64` |

## MultiSignature Transaction

TBD

## IPFS Transaction

### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 5,
    "nonce": "2",
    "senderPublicKey": "038e000c902d4551065ac5705637c685d52e6ac4032e158ad0370c5ef2bbafae2c",
    "fee": "500000000",
    "amount": "0",
    "asset": {
        "ipfs": "QmYSK2JyM3RyDyB52caZCTKFR3HKniEcMnNJYdk8DQ6KKB"
    },
    "signature": "ed8e729b40e73ab86c3b6675d463c19d88495bf4e091037e80352afe0ea29efff04d2667bfe8d78e5c4ad410fb0f7a0f511fbd657a54181aca8de4e8c6ebfe2c",
    "id": "77d8134144780e50db71adb496e02bcbde43e76a0cd7eeae7ff3641db75187ec",
}
```

### Serialized Payload

```text
ff02170100000005000200000000000000038e000c902d4551065ac5705637c685d52e6ac4032e158ad0370c5ef2bbafae2c0065cd1d000000000012209608184d6cee2b9af8e6c2a46fc9318adf73329aeb8a86cf8472829fff5bb89eed8e729b40e73ab86c3b6675d463c19d88495bf4e091037e80352afe0ea29efff04d2667bfe8d78e5c4ad410fb0f7a0f511fbd657a54181aca8de4e8c6ebfe2c
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **TypeGroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0500` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x038e000c902d4551065ac5705637c685d52e6ac4032e158ad0370c5ef2bbafae2c` |
| **Fee:** | **\[50\]** | **8** | `0x0065cd1d00000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **IPFS Hash:** | **\[59\]** | **34** | `0x12209608184d6cee2b9af8e6c2a46fc9318adf73329aeb8a86cf8472829fff5bb89e` |
| **Signature:** | **\[93\]** | **64** | `0xed8e729b40e73ab86c3b6675d463c19d88495bf4e091037e80352afe0ea29efff04d2667bfe8d78e5c4ad410fb0f7a0f511fbd657a54181aca8de4e8c6ebfe2c` |

### IPFS Hash Breakdown

| Item | Length | Value |
| :--- | :---: | :--- |
| **IPFS Hash** | **46** _**\(chars\)**_ | `QmYSK2JyM3RyDyB52caZCTKFR3HKniEcMnNJYdk8DQ6KKB` |
| **Decoded Base58** | **34** _**\(bytes\)**_ | `0x12209608184d6cee2b9af8e6c2a46fc9318adf73329aeb8a86cf8472829fff5bb89e` |
| **Hash Type** | **1** _**\(byte\)**_ | `0x12` |
| **Hash Length** | **1** _**\(byte\)**_ | `0x20` |
| **32-Byte Hash** | **32** _**\(bytes\)**_ | `0x9608184d6cee2b9af8e6c2a46fc9318adf73329aeb8a86cf8472829fff5bb89e` |

## MultiPayment Transaction

TBD

## Delegate Resignation

### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 7,
    "nonce": "2",
    "senderPublicKey": "037a12518205254e6ebf25290d9786fd9821c43bb7319c9fc2499c8d472809dfaf",
    "fee": "2500000000",
    "amount": "0",
    "signature": "ad7a61a76433260ef9dc687311ab6c657f6c733dbf1a80c3514da823d43226235a70a94fa1a0b8cb2f4b3d0be5011945bfbe8c8fc5b5ca0e07f6c2a37e3cf11b",
    "id": "ee2a5253e28f66d5546b28bba96b4fa88973305e2e0d3b82afd5b3386ab0b6d4"
}
```

### Serialized Payload

```text
ff02170100000007000200000000000000037a12518205254e6ebf25290d9786fd9821c43bb7319c9fc2499c8d472809dfaf00f902950000000000ad7a61a76433260ef9dc687311ab6c657f6c733dbf1a80c3514da823d43226235a70a94fa1a0b8cb2f4b3d0be5011945bfbe8c8fc5b5ca0e07f6c2a37e3cf11b
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0700` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x037a12518205254e6ebf25290d9786fd9821c43bb7319c9fc2499c8d472809dfaf` |
| **Fee:** | **\[50\]** | **8** | `0x00f9029500000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Signature:** | **\[59\]** | **64** | `0xad7a61a76433260ef9dc687311ab6c657f6c733dbf1a80c3514da823d43226235a70a94fa1a0b8cb2f4b3d0be5011945bfbe8c8fc5b5ca0e07f6c2a37e3cf11b` |

## HTLC Lock

### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 8,
    "nonce": "2",
    "senderPublicKey": "0207ebc33a5f6eddf623706b6645b785eaa4405d14f80556461d8f78e0b1cb1884",
    "fee": "10000000",
    "amount": "1",
    "recipientId": "AZqDtF6WbksWaE2DSH6CVRV5kqvoCwnnnq",
    "asset": {
        "lock": {
            "secretHash": "09b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c",
            "expiration": {
                "type": 1,
                "value": 78127967
            }
        }
    },
    "signature": "de19469ac62a66898814a1a2c9e396b826df1a1e1296191c66b10f09df412f7313d80c8c8d09a629094acc118fc42de048112921cd030b59c85536fc5471b05a",
    "id": "5dfcae6b5d954d05de58ef4d75693e515155e5fe8b08d44c78dffdf41e2c790e"
}
```

### Serialized Payload

```text
ff021701000000080002000000000000000207ebc33a5f6eddf623706b6645b785eaa4405d14f80556461d8f78e0b1cb1884809698000000000000010000000000000009b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c015f23a8040000000017c61467acf99231ed0c717ca9c6bbf6fb44b1d138de19469ac62a66898814a1a2c9e396b826df1a1e1296191c66b10f09df412f7313d80c8c8d09a629094acc118fc42de048112921cd030b59c85536fc5471b05a
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0800` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x0207ebc33a5f6eddf623706b6645b785eaa4405d14f80556461d8f78e0b1cb1884` |
| **Fee:** | **\[50\]** | **8** | `0x8096980000000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Amount:** | **\[59\]** | **8** | `0x0100000000000000` |
| **Secret Hash:** | **\[67\]** | **32** | `0x09b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c` |
| **Expiration Type:** | **\[99\]** | **1** | `0x01` |
| **Expiration Value:** | **\[100\]** | **8** | `0x5f23a80400000000` |
| **Recipient:** | **\[108\]** | **21** | `0x17c61467acf99231ed0c717ca9c6bbf6fb44b1d138` |
| **Signature:** | **\[129\]** | **64** | `0xde19469ac62a66898814a1a2c9e396b826df1a1e1296191c66b10f09df412f7313d80c8c8d09a629094acc118fc42de048112921cd030b59c85536fc5471b05a` |

> _htlc asset numbers are little-endian packed_

## HTLC Claim

### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 9,
    "nonce": "2",
    "senderPublicKey": "0295b4261317ef9f27592fae7739438c49685fed351586dbc26a9cd871885a121a",
    "fee": "0",
    "amount": "0",
    "asset": {
        "claim": {
            "lockTransactionId": "09b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c",
            "unlockSecret": "f5ea877a311ced90cf4524cb489e972f"
        }
    },
    "signature": "b05241178d54cdc625e4fc251dd939acbd2617295ea9dfd8282f1e3ccad8019718e278c10f291a25afb002ae253c139949d0fdbd6badb4b7616d70faf8c7b43e",
    "id": "af7702fd837c08ab0d63a7225a5549626afd209141fa3086f425797eb111350b"
}
```

### Serialized Payload

```text
ff021701000000090002000000000000000295b4261317ef9f27592fae7739438c49685fed351586dbc26a9cd871885a121a00000000000000000009b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c6635656138373761333131636564393063663435323463623438396539373266b05241178d54cdc625e4fc251dd939acbd2617295ea9dfd8282f1e3ccad8019718e278c10f291a25afb002ae253c139949d0fdbd6badb4b7616d70faf8c7b43e
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0900` |
| **Nonce:** | **\[9\]** | **8** | `0x0200000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x0295b4261317ef9f27592fae7739438c49685fed351586dbc26a9cd871885a121a` |
| **Fee:** | **\[50\]** | **8** | `0x0000000000000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Lock Id:** | **\[59\]** | **32** | `0x09b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c` |
| **Unlock Secret:** | **\[91\]** | **32** | `0x6635656138373761333131636564393063663435323463623438396539373266` |
| **Signature:** | **\[123\]** | **64** | `0xad7a61a76433260ef9dc687311ab6c657f6c733dbf1a80c3514da823d43226235a70a94fa1a0b8cb2f4b3d0be5011945bfbe8c8fc5b5ca0e07f6c2a37e3cf11b` |

## HTLC Refund

### Signed JSON Payload

```javascript
{
    "version": 2,
    "network": 23,
    "type": 10,
    "nonce": "3",
    "senderPublicKey": "02a53371b23f991740f968e3d96de42a67b4242e267cad8050ae4b68bf9ac20af2",
    "fee": "0",
    "amount": "0",
    "asset": {
        "refund": {
            "lockTransactionId": "09b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c"
        }
    },
    "signature": "d3273eb5c13027f789939f999742d7a1d015e75f8ad29dc6482b84f320445c2cb29c3fd62168c1009d4ef000d7ad41d4295b755276c4eb3a604c7b07337f69cb",
    "id": "c77777da8e2ea747bacbab1c8e673e6ab32e5152be22eb6b1e0cfc9189908871",
}
```

### Serialized Payload

```text
ff0217010000000a00030000000000000002a53371b23f991740f968e3d96de42a67b4242e267cad8050ae4b68bf9ac20af200000000000000000009b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78cd3273eb5c13027f789939f999742d7a1d015e75f8ad29dc6482b84f320445c2cb29c3fd62168c1009d4ef000d7ad41d4295b755276c4eb3a604c7b07337f69cb
```

### Deserialized Hex Payload

| Key | Pos. | Size _\(bytes\)_ | Value  _\(hex\)_ |
| :--- | :---: | :---: | :--- |
| **Header:** | **\[0\]** | **1** | `0xff` |
| **Version:** | **\[1\]** | **1** | `0x02` |
| **Network:** | **\[2\]** | **1** | `0x17` |
| **Typegroup:** | **\[3\]** | **4** | `0x01000000` |
| **Type:** | **\[7\]** | **2** | `0x0a00` |
| **Nonce:** | **\[9\]** | **8** | `0x0300000000000000` |
| **SenderPublicKey:** | **\[17\]** | **33** | `0x02a53371b23f991740f968e3d96de42a67b4242e267cad8050ae4b68bf9ac20af2` |
| **Fee:** | **\[50\]** | **8** | `0x0000000000000000` |
| **VendorField Length:** | **\[58\]** | **1** | `0x00` |
| **Lock Id:** | **\[59\]** | **32** | `0x09b9a28393efd02fcd76a21b0f0f55ba2aad8f3640ff8cae86de033a9cfbd78c` |
| **Signature:** | **\[91\]** | **64** | `ad7a61a76433260ef9dc687311ab6c657f6c733dbf1a80c3514da823d43226235a70a94fa1a0b8cb2f4b3d0be5011945bfbe8c8fc5b5ca0e07f6c2a37e3cf11b` |





