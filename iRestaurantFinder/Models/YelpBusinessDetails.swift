//
//  YelpBusinessDetails.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/27/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import Foundation
import MapKit

class YelpBusinessDetails: NSObject, Codable {
    let name: String
    let isClosed: Bool
    let rating: Double
//    let price: String
    let photos: [URL]
    let phone: String
    let coordinates: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case name
        case isClosed = "is_closed"
        case rating
        case coordinates
//        case price = "price"
        case phone
        case photos
    }
}

extension YelpBusinessDetails: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    var title: String? {
        return name
    }
}
