//
//  OutputDescriptorsTests.swift
//  OutputDescriptorsTests
//
//  Created by Sjors Provoost on 13/12/2019.
//  Copyright © 2019 Sjors Provoost. Distributed under the MIT software
//  license, see the accompanying file LICENSE.md
//

import XCTest
@testable import OutputDescriptors

class OutputDescriptorsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidDescriptor(_ descriptor: String, _ outputType: OutputDescriptor.OutputType, _ descriptorType: OutputDescriptor.DescriptorType) {
        XCTAssertNoThrow(try OutputDescriptor(descriptor))
        let desc = try! OutputDescriptor(descriptor)
        if descriptor.suffix(9).prefix(1) == "#" {
            XCTAssertEqual(desc.descriptor, String(descriptor.dropLast(9)))
        } else {
            XCTAssertEqual(desc.descriptor, descriptor)
        }
        XCTAssertEqual(desc.outputType, outputType)
        XCTAssertEqual(desc.descType, descriptorType)
    }
    
    func testInvalidDescriptor(_ descriptor: String, _ expectedError: Error) {
        XCTAssertThrowsError(try OutputDescriptor(descriptor)) {error in
            XCTAssertEqual(String(describing: error), String(describing: expectedError))
        }

    }

    func testLength() {
        testInvalidDescriptor("", OutputDescriptor.ParseError.tooShort)
    }
    
    func testInvalidCharacters() {
        testInvalidDescriptor("💩", OutputDescriptor.ParseError.invalidCharacter)
    }
    
    func testSetDescriptorString() {
        // BIP32 test vector 1 at m/0'/1
        testValidDescriptor("wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)", .segWit, .pubkeyHash)
    }
    
    func testChecksum(_ expectedChecksum: String, _ descriptor: String) {
        let checksum = try! OutputDescriptor(descriptor).checksum
        XCTAssertEqual(checksum, expectedChecksum)
    }
    
    func testChecksums() {
        testChecksum("e0lhcajv", "wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)")
        testChecksum("p956d68g", "wpkh(KyFAjQ5rgrKvhXvNMtFB5PCSKUYD1yyPEe3xr3T34TZSUHycXtMM)")
        testChecksum("8asu2299", "wpkh([3442193e/0'/1]03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)")
        testChecksum("2gtje8py", "wpkh([3442193e/0h/1]03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)")
    }
    
    func testChecksumIncluded() {
        testInvalidDescriptor("wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)#e0lhcaj0", OutputDescriptor.ParseError.invalidChecksum)
        
        testValidDescriptor("wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)#e0lhcajv", .segWit, .pubkeyHash)

    }
    
    func testParseMultisig() {
        let descriptor = "wsh(sortedmulti(2,[3442193e/48h/0h/0h/2h]xpub6E64WfdQwBGz85XhbZryr9gUGUPBgoSu5WV6tJWpzAvgAmpVpdPHkT3XYm9R5J6MeWzvLQoz4q845taC9Q28XutbptxAmg7q8QPkjvTL4oi/0/*,[bd16bee5/48h/0h/0h/2h]xpub6DwQ4gBCmJZM3TaKogP41tpjuEwnMH2nWEi3PFev37LfsWPvjZrh1GfAG8xvoDYMPWGKG1oBPMCfKpkVbJtUHRaqRdCb6X6o1e9PQTVK88a/0/*))"
        testValidDescriptor(descriptor, .segWit, .sortedMulti(threshold: 2))
        testValidDescriptor("sh(wsh(sortedmulti(2,[3442193e/48h/0h/0h/2h]xpub6E64WfdQwBGz85XhbZryr9gUGUPBgoSu5WV6tJWpzAvgAmpVpdPHkT3XYm9R5J6MeWzvLQoz4q845taC9Q28XutbptxAmg7q8QPkjvTL4oi/0/*,[bd16bee5/48h/0h/0h/2h]xpub6DwQ4gBCmJZM3TaKogP41tpjuEwnMH2nWEi3PFev37LfsWPvjZrh1GfAG8xvoDYMPWGKG1oBPMCfKpkVbJtUHRaqRdCb6X6o1e9PQTVK88a/0/*)))", .wrappedSegwit, .sortedMulti(threshold: 2))
        testInvalidDescriptor("sh(wsh(sortedmulti(abc,))", OutputDescriptor.ParseError.invalidParam)
        testInvalidDescriptor("sh(wsh(sortedmulti(3,only_one))", OutputDescriptor.ParseError.invalidParam)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
