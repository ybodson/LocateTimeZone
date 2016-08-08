//
//  TimeZoneLocator.swift
//  LocateTimeZone
//
//  Created by Yann Bodson on 5/08/2016.
//  Copyright © 2016 frogmojo. All rights reserved.
//

import Foundation
import CoreLocation


private let bundleID = "com.frogmojo.LocateTimeZone"
private let zonesFilename = "zone"


public class TimeZoneLocator: NSObject {

    private var zones: TimeZoneParser.TimeZones?

    public override init() {
        super.init()
        loadTimeZonesFromBundle(bundleID, filename: zonesFilename)
    }

    public func locationForZone(zoneID: String) -> CLLocationCoordinate2D {
        return zones?[zoneID] ?? CLLocationCoordinate2D()
    }
}


private extension TimeZoneLocator {

    func loadTimeZonesFromBundle(bundleID: String, filename: String) {
        if let bundle = NSBundle(identifier: bundleID), path = bundle.pathForResource(filename, ofType: "tab") {
            let parser = TimeZoneParser(filePath: path)
            zones = parser.parseData()
        }
    }
}
