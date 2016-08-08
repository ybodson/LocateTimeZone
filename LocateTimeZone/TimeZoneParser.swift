//
//  TimeZoneParser.swift
//  LocateTimeZone
//
//  Created by Yann Bodson on 5/08/2016.
//  Copyright © 2016 frogmojo. All rights reserved.
//

import Foundation
import CoreLocation


class TimeZoneParser {

    typealias TimeZones = [String: CLLocationCoordinate2D]

    enum ParseError: ErrorType {
        case FormatError
    }

    private let filePath: String

    init(filePath: String) {
        self.filePath = filePath
    }

    func parseData() -> TimeZones {
        return TimeZoneParser.parseFile(filePath)
    }
}


private extension TimeZoneParser {

    class func parseFile(filePath: String) -> TimeZones {
        var zoneInfos = TimeZones()
        do {
            let data = try String(contentsOfFile: filePath)
            let lines = data.componentsSeparatedByString("\n")
            for line in lines {
                if let zone = TimeZoneParser.parseLine(line) {
                    zoneInfos[zone.name] = zone.coordinates
                }
            }
        } catch {
            print(error)
        }
        return zoneInfos
    }

    class func parseLine(line: String) -> (name: String, coordinates: CLLocationCoordinate2D)? {
        if line.hasPrefix("#") { return nil }
        let lineFields = line.componentsSeparatedByString("\t")
        if lineFields.count < 3 { return nil }
        do {
            let coordinates = try location(from: lineFields[1])
            return (lineFields[2], coordinates)
        } catch {
            print(error)
            return nil
        }
    }

    class func signedCoordinate(string: String, location: Int, length: Int) -> Double {
        let s = string as NSString
        let sign = (s.substringWithRange(NSRange(location: location, length: 1)) == "+") ? 1.0 : -1.0
        let value = Double(s.substringWithRange(NSRange(location: location + 1, length: length - 1)))
        return sign * (value ?? 0)
    }

    class func location(from iso6709: String) throws -> CLLocationCoordinate2D {
        if iso6709.characters.count == 11 {
            let latitude = signedCoordinate(iso6709, location: 0, length: 5) / 100.0
            let longitude = signedCoordinate(iso6709, location: 5, length: 6) / 100.0
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else if iso6709.characters.count == 15 {
            let latitude = signedCoordinate(iso6709, location: 0, length: 7) / 10000.0
            let longitude = signedCoordinate(iso6709, location: 7, length: 8) / 10000.0
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            throw ParseError.FormatError
        }
    }
    
}
