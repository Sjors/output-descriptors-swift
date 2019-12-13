import OutputDescriptors

let descriptor = "wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)"
let desc = OutputDescriptor(descriptor)
print("\(descriptor)#\(desc.checksum)")
