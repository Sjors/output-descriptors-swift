# Output Descriptors for Swift [![Build Status](https://travis-ci.org/sjors/output-descriptors-swift.svg?branch=master)](https://travis-ci.org/sjors/output-descriptors-swift)

Output Descriptors are a simple language which can be used to describe collections
of output scripts. They were introduced in Bitcoin Core 0.17. See
[descriptors.md](https://github.com/bitcoin/bitcoin/blob/master/doc/descriptors.md)
to learn more.

This implementation is very limited; it currently only supports:

* calculating and verifying the checksum for a descriptor string
* parsing a limited set of descriptor types

## Install

Via CocoaPods:

```
pod 'OutputDescriptor', :git => 'https://github.com/sjors/output-descriptors-swift.git', :branch => 'master'
```

## Usage

```swift
import OutputDescriptors
let descriptor = "wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)"
let desc = try! OutputDescriptor(descriptor)
print("\(descriptor)#\(desc.checksum)")
// wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)#e0lhcajv
```

```swift
let descriptor = "wsh(sortedmulti(2,[3442193e/48h/0h/0h/2h]xpub6E64WfdQwBGz85XhbZryr9gUGUPBgoSu5WV6tJWpzAvgAmpVpdPHkT3XYm9R5J6MeWzvLQoz4q845taC9Q28XutbptxAmg7q8QPkjvTL4oi/0/*,[bd16bee5/48h/0h/0h/2h]xpub6DwQ4gBCmJZM3TaKogP41tpjuEwnMH2nWEi3PFev37LfsWPvjZrh1GfAG8xvoDYMPWGKG1oBPMCfKpkVbJtUHRaqRdCb6X6o1e9PQTVK88a/0/*))"
let desc = try! OutputDescriptor(descriptor)
print(desc.descType)
// sortedMulti(threshold: 2)
print(desc.extendedKeys.first!.fingerprint)
// 3442193e
```
