# Output Descriptors for Swift [![Build Status](https://travis-ci.org/sjors/output-descriptors-swift.svg?branch=master)](https://travis-ci.org/sjors/output-descriptors-swift)

Output Descriptors are a simple language which can be used to describe collections
of output scripts. They were introduced in Bitcoin Core 0.17. See
[descriptors.md](https://github.com/bitcoin/bitcoin/blob/master/doc/descriptors.md)
to learn more.

This implementation is very limited; it currently only supports calculating
the checksum for a descriptor string.

## Install

Via CocoaPods:

```
pod 'OutputDescriptor', :git => 'https://github.com/sjors/output-descriptors-swift.git', :branch => 'master'
```

## Usage

```swift
import OutputDescriptors
let descriptor = "wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)"
let desc = OutputDescriptor(descriptor)
print("\(descriptor)#\(desc.checksum)")
// wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)#e0lhcajv
```
