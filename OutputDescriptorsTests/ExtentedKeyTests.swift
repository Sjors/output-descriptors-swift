//
//  ExtendedKeyTests.swift
//  ExtendedKeyTests
//
//  Created by Sjors Provoost on 27/11/2020.
//  Copyright © 2020 Sjors Provoost. Distributed under the MIT software
//  license, see the accompanying file LICENSE.md

import XCTest
@testable import OutputDescriptors

class ExtendedKeyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() throws {
        let extKey = try! ExtendedKey("[3442193e/48h/0h/0h/2h]xpub6E64WfdQwBGz85XhbZryr9gUGUPBgoSu5WV6tJWpzAvgAmpVpdPHkT3XYm9R5J6MeWzvLQoz4q845taC9Q28XutbptxAmg7q8QPkjvTL4oi/0/*")
        XCTAssertNotNil(extKey)
        XCTAssertEqual(extKey.fingerprint, "3442193e")
        XCTAssertEqual(extKey.origin, "m/48h/0h/0h/2h")
        XCTAssertEqual(extKey.xpub, "xpub6E64WfdQwBGz85XhbZryr9gUGUPBgoSu5WV6tJWpzAvgAmpVpdPHkT3XYm9R5J6MeWzvLQoz4q845taC9Q28XutbptxAmg7q8QPkjvTL4oi")
        XCTAssertEqual(extKey.derivation, "0/*")

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
