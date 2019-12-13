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
