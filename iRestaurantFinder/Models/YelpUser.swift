//
//  YelpUser.swift
//  RestaurantReviews
//
//  Created by Samuel Yanez on 5/3/19.
//  Copyright © 2019 Samuel Yanez. All rights reserved.
//

import Foundation
import UIKit

struct YelpUser: Codable {
    
    enum ImageDownloadState: String, Codable {
        case placeholder, downloaded, failed

        init?(rawValue: String) {
            switch rawValue {
            case "placeholder": self = .placeholder
            case "downloaded": self = .downloaded
            case "failed": self = .failed
            default: return nil
            }
        }
    }
    
    let name: String
    let imageUrl: String
//    let image: UIImage?
    var imageState: ImageDownloadState = .placeholder
    
//    required init?(json: [String : Any]) {
//        guard let imageUrl = json["image_url"] as? String, let name = json["name"] as? String else { return nil }
//        self.imageUrl = imageUrl
//        self.name = name
//        self.image = nil
//    }
}
