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
    
    func testValidDescriptor(_ descriptor: String) {
        XCTAssertNoThrow(try OutputDescriptor(descriptor))
        let desc = try! OutputDescriptor(descriptor)
        XCTAssertEqual(desc.descriptor, descriptor)
    }
    
    func testInvalidDescriptor(_ descriptor: String, _ expectedError: Error) {
        XCTAssertThrowsError(try OutputDescriptor(descriptor)) {error in
            XCTAssertEqual(String(describing: error), String(describing: expectedError))
        }

    }
    

    func testLength() {
        testInvalidDescriptor("", OutputDescriptor.ParseError.tooShort)
    }
    
    func testSetDescriptorString() {
        // BIP32 test vector 1 at m/0'/1
        testValidDescriptor("wpkh(03501e454bf00751f24b1b489aa925215d66af2234e3891c3b21a52bedb3cd711c)")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
