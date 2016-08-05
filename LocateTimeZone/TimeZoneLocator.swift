//
//  TimeZoneLocator.swift
//  LocateTimeZone
//
//  Created by Yann Bodson on 5/08/2016.
//  Copyright © 2016 frogmojo. All rights reserved.
//

import Foundation
import CoreLocation

public class TimeZoneLocator: NSObject {

    private var zones: TimeZoneParser.TimeZones?

    public override init() {
        if let bundle = NSBundle(identifier: "com.frogmojo.LocateTimeZone") {
            if let path = bundle.pathForResource("zone", ofType: "tab") {
                let parser = TimeZoneParser(filePath: path)
                zones = parser.parseData()
            }
        }
    }

    public func locationForZone(zoneID: String) -> CLLocationCoordinate2D {
        return zones?[zoneID] ?? CLLocationCoordinate2D()
    }
}
