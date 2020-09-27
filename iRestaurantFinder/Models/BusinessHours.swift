//
//  BusinessHours.swift
//  RestaurantReviews
//
//  Created by Samuel Yanez on 5/3/19.
//  Copyright © 2019 Samuel Yanez. All rights reserved.
//

import Foundation

struct BusinessHours: Codable {
    enum HoursType: String, Codable {
        case regular
        
        init?(rawValue: String) {
            switch rawValue {
            case "REGULAR": self = .regular
            default: return nil
            }
        }
    }
    
    struct Schedule: Codable {
        enum Day: Int, Codable {
            case monday = 0
            case tuesday
            case wednesday
            case thursday
            case friday
            case saturday
            case sunday
        }
        
        let isOvernight: Bool
        let start: String
        let end: String
        let day: Day
    }
    
    let schedule: [Schedule]
    let type: HoursType
    let isOpenNow: Bool
}

//extension BusinessHours.Schedule: JSONDecodable {
//    init?(json: [String : Any]) {
//        guard let isOvernight = json["is_overnight"] as? Bool, let start = json["start"] as? String, let end = json["end"] as? String, let dayValue = json["day"] as? Int, let day = BusinessHours.Schedule.Day(rawValue: dayValue) else { return nil }
//
//        self.isOvernight = isOvernight
//        self.start = start
//        self.end = end
//        self.day = day
//    }
//}
//
//extension BusinessHours: JSONDecodable {
//    init?(json: [String : Any]) {
//        guard let openHours = json["open"] as? [[String: Any]], let hoursTypeString = json["hours_type"] as? String, let hoursType = HoursType(string: hoursTypeString), let isOpenNow = json["is_open_now"] as? Bool else { return  nil }
//
//        self.type = hoursType
//        self.isOpenNow = isOpenNow
//        self.schedule = openHours.compactMap { BusinessHours.Schedule(json: $0) }
//    }
//}
