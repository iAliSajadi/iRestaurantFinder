//
//  YelpClient.swift
//  RestaurantReviews
//
//  Created by Samuel Yanez on 5/11/19.
//  Copyright © 2019 Samuel Yanez. All rights reserved.
//

import UIKit

class YelpClient: APIClient {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func search(withTerm term: String?, at coordinate: Coordinate, categories: [YelpCategory] = [], radius: Int? = nil, limit: Int = 50, sortBy sortType: Yelp.YelpSortType = .rating, completion: @escaping (Result<[YelpBusiness], Error>) -> Void) {
        
        let endpoint = Yelp.search(term: term ?? "", coordinate: coordinate, radius: radius, categories: categories, limit: limit, sortBy: sortType)
        let request = endpoint.authorizedRequest(withKey: YelpKeys.token)
        
        fetchAll(with: request, completion: completion)
    }
    
    func business(withID id: String, completion: @escaping (Result<YelpBusiness, Error>) -> Void) {
        let endpoint = Yelp.business(id: id)
        let request = endpoint.authorizedRequest(withKey: YelpKeys.token)
        fetch(with: request, completion: completion)
    }
    
    func updateBusiness(_ business: YelpBusiness, completion: @escaping (Result<YelpBusiness, Error>) -> Void) {
        let endpoint = Yelp.business(id: business.id)
        let request = endpoint.authorizedRequest(withKey: YelpKeys.token)
        
        fetch(with: request, completion: completion)
    }
    
//    func getRestaurantImage(with Url: URL) -> UIImage? {
//        var restaurantImage: UIImage?
//        fetchRestaurantImage(with: Url) { result in
//            switch result {
//            case .success(let image):
//                restaurantImage = image
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        }
//        return restaurantImage
//    }
    
    func getRestaurantImage(with Url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        fetchRestaurantImage(with: Url, completion: completion)
    }
}
