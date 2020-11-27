import OutputDescriptors

var descriptor = "wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)"
var desc = try! OutputDescriptor(descriptor)
print("\(descriptor)#\(desc.checksum)")
print(desc.outputType)
print(desc.descType)

descriptor = "wsh(sortedmulti(2,[3442193e/48h/0h/0h/2h]xpub6E64WfdQwBGz85XhbZryr9gUGUPBgoSu5WV6tJWpzAvgAmpVpdPHkT3XYm9R5J6MeWzvLQoz4q845taC9Q28XutbptxAmg7q8QPkjvTL4oi/0/*,[bd16bee5/48h/0h/0h/2h]xpub6DwQ4gBCmJZM3TaKogP41tpjuEwnMH2nWEi3PFev37LfsWPvjZrh1GfAG8xvoDYMPWGKG1oBPMCfKpkVbJtUHRaqRdCb6X6o1e9PQTVK88a/0/*))"
desc = try! OutputDescriptor(descriptor)
print(desc.descType)
print(desc.extendedKeys.first!.fingerprint)
