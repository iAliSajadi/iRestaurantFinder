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

class YelpBusiness: Codable {
    
    let id: String
    let name: String
    let imageUrl: String
    let url: String
    let categories: [YelpCategory]
    let transactions: [YelpTransaction]
    let location: Address
    let displayPhone: String
    
    // Only available through search results not direct business queries
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case url
        case categories
        case transactions
        case location
        case displayPhone = "display_phone"
        case distance
    }
}

//extension YelpBusiness: MKAnnotation {
//    
//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
//    }
//    
//    var title: String? {
//        return name
//    }
//}
