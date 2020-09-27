//
//  YelpBusiness.swift
//  RestaurantReviews
//
//  Created by Samuel Yanez on 5/3/19.
//  Copyright © 2019 Samuel Yanez. All rights reserved.
//

import Foundation
import MapKit

struct YelpResponse: Codable {
    let businesses: [YelpBusiness]
}

class YelpBusiness: NSObject, Codable {
    
    let id: String
    let name: String
    let imageUrl: String
    let isClosed: Bool
    let url: String
    let categories: [YelpCategory]
    let rating: Double
    let coordinates: Coordinate
    let transactions: [YelpTransaction]
//    let price: String
    let location: Address
    let phone: String
    let displayPhone: String
    
    // Only available through search results not direct business queries
    var distance: Double?
    
    // Detail properties
//    var photos: [String]
//    var hours: BusinessHours?
//    var isOpenNow: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case url
        case categories
        case rating
        case coordinates
        case transactions
//        case price
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
//        case photos
//        case hours
//        case isOpenNow
    }
}

extension YelpBusiness: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    var title: String? {
        return name
    }
}
