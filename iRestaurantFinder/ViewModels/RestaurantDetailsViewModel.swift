//
//  RestaurantDetailsViewModel.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/27/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import Foundation

struct RestaurantDetailsViewModel {
//    let price: String
    let isOpen: String
    let phoneNumber: String
    let rating: String
    let imageUrls: [URL]
    let coordinate: Coordinate
    
    init(details: YelpBusinessDetails) {
//        self.price = details.price
        self.isOpen = details.isClosed ? "Closed" : "Open"
        self.phoneNumber = details.phone
        self.rating = "\(details.rating) / 5"
        self.imageUrls = details.photos
        self.coordinate = details.coordinates
    }
}
