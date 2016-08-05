//
//  TimeZoneLocator.swift
//  LocateTimeZone
//
//  Created by Yann Bodson on 5/08/2016.
//  Copyright © 2016 frogmojo. All rights reserved.
//

import Foundation

public class TimeZoneLocator {

    private var zones: TimeZoneParser.TimeZones?

    public init() {
        if let bundle = NSBundle(identifier: "com.frogmojo.LocateTimeZone") {
            if let path = bundle.pathForResource("zone", ofType: "tab") {
                let parser = TimeZoneParser(filePath: path)
                zones = parser.parseData()
            }
        }
    }

    public func locationForZone(zoneID: String) -> (latitude: Double, longitude: Double)? {
        return zones?[zoneID]
    }
}
