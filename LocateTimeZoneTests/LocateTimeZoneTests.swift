//
//  LocateTimeZoneTests.swift
//  LocateTimeZoneTests
//
//  Created by Yann Bodson on 5/08/2016.
//  Copyright © 2016 frogmojo. All rights reserved.
//

import XCTest
@testable import LocateTimeZone

class LocateTimeZoneTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTimeZoneParser() {
        if let bundle = NSBundle(identifier: "com.frogmojo.LocateTimeZone") {
            if let path = bundle.pathForResource("zone", ofType: "tab") {
                let parser = TimeZoneParser(filePath: path)
                let zones = parser.parseData()
                XCTAssertNotNil(zones)
            }
        }
    }

    func testTimeZoneLocator() {
        let locator = TimeZoneLocator()
        for zone in NSTimeZone.knownTimeZoneNames() {
            if let coord = locator.locationForZone(zone) {
                //print(zone, coord)
            } else {
                print(zone, "NOT FOUND")
            }
        }
    }

}
