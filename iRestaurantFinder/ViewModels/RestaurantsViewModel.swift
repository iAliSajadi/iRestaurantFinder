//
//  RestaurantsViewModel.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import Foundation

struct RestaurantsViewModel {
    let id: String
    let name: String
    let distance: Double
    let imageUrl: URL
    
    var numberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }
    
    var formattedDistance: String? {
        return numberFormatter.string(from: distance as NSNumber)
    }
    
    init(business: YelpBusiness) {
        self.id = business.id
        self.name = business.name
        self.imageUrl = URL(string: business.imageUrl)!
        self.distance = (business.distance! / 1000)
    }
}
