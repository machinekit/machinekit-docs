machinetalk-protobuf
====================

Protobuf declarations for machinekit messages

This repo is integrated into github.com/machinekit/machinekit as a git subtree.

To change/add to message definitions:

* send a PR against this repo
* add a new remote in your machinekit repo referring to here
* update the subtree in your machinekit repo like so

`````
git remote add machinetalk-protobuf git://github.com/machinekit/machinetalk-protobuf.git
git fetch machinetalk-protobuf
git subtree merge --prefix=src/machinetalk/proto machinetalk-protobuf/master --squash
`````

Now create a PR against the machinekit repo.

## Javascript (NPM/NodeJS)

### Installation

To use machinetalk protobuf definitions in your npm-based projects, use:

```sh
npm install --save machinetalk-protobuf
```

### Usage

See [examples](js/examples). If you want to try these examples, be sure to first run `npm install` in this repository.

#### Encoding

```js
var machinetalkProtobuf = require('machinetalk-protobuf');
var messageContainer = {
  type: machinetalkProtobuf.message.ContainerType.MT_PING
};
var encodedMessageContainer = machinetalkProtobuf.message.Container.encode(messageContainer);
```
This results in a buffer that starts with `0x08 0xd2 0x01`.

#### Decoding

```js
var machinetalkProtobuf = require('machinetalk-protobuf');
var encodedBuffer = new Buffer([0x08, 0xd2, 0x01]);
var decodedMessageContainer = machinetalkProtobuf.message.Container.decode(encodedBuffer);
```
This results in a messageContainer like the one defined in [Encoding](#Encoding).
