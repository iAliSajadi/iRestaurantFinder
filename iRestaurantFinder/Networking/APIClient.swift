//
//  APIClient.swift
//  RestaurantReviews
//
//  Created by Samuel Yanez on 5/11/19.
//  Copyright © 2019 Samuel Yanez. All rights reserved.
//

import UIKit

protocol APIClient {
    var session: URLSession { get }
    
//    func fetch<T: Codable>(with request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void)
//    func fetchAll<T: Codable>(with request: URLRequest, completion: @escaping (Result<[T], APIError>) -> Void)
    
    func fetch(with request: URLRequest, completion: @escaping (Result<YelpBusiness, Error>) -> Void)
    func fetchAll(with request: URLRequest, completion: @escaping (Result<[YelpBusiness], Error>) -> Void)
    func fetchRestaurantImage(with Url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void)
}

extension APIClient {
    var JsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
//    typealias JSON = [String: AnyObject]
//    typealias JSONTaskCompletionHandler = (JSON?, APIError?) -> Void
    
//    func jsonTask(with request: URLRequest, completionHandler completion: @escaping (Result<YelpBusiness, APIError>) -> Void) -> URLSessionDataTask {
//       return session.dataTask(with: request) { data, response, error in
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.requestFailed))
//                return
//            }
//            if httpResponse.statusCode == 200 {
//                if let data = data {
//                    do {
//                        let result = try self.decoder.decode(YelpBusiness.self, from: data)
//                        completion(.success(result))
//                    } catch {
//                        completion(.failure(.jsonConversionFailure))
//                    }
//                } else {
//                    completion(.failure(.invalidData))
//                }
//            } else {
//                completion(.failure(.responseUnsuccessful))
//            }
//        }
//    }
    
//    func fetch(with request: URLRequest, completion: @escaping (Result<YelpBusiness, APIError>) -> Void) {
//        jsonTask(with: request) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let yelpBusiness):
//                    completion(.success(yelpBusiness))
//                case .failure:
//                    completion(.failure(.invalidData))
//                }
//            }
//        }.resume()
//    }
    
//    func fetchAll(with request: URLRequest, completion: @escaping (Result<[YelpBusiness], APIError>) -> Void) {
//        jsonTask(with: request) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let yelpBusinesses):
//                    completion(.success(yelpBusinesses))
//                case .failure:
//                    completion(.failure(.invalidData))
//                }
//            }
//        }.resume()
//    }
    
    func fetch(with request: URLRequest, completion: @escaping (Result<YelpBusiness, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.requestFailed))
                completion(.failure(error!))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let yelpBusiness = try self.JsonDecoder.decode(YelpBusiness.self, from: data)
                        OperationQueue.main.addOperation {
                        completion(.success(yelpBusiness))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
//                    completion(.failure(.invalidData))
                    completion(.failure(error!))
                }
            } else {
//                completion(.failure(.responseUnsuccessful))
                completion(.failure(error!))
            }
        }.resume()
    }
        
    func fetchAll(with request: URLRequest, completion: @escaping (Result<[YelpBusiness], Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.requestFailed))
                completion(.failure(error!))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
//                        let jsonString = String(data: data, encoding: .utf8)
//                        print(jsonString!)
                        let yelpResponse = try self.JsonDecoder.decode(YelpResponse.self, from: data)
                        OperationQueue.main.addOperation {
                        completion(.success(yelpResponse.businesses))
                        }
                    } catch {
//                        completion(.failure(.jsonConversionFailure))
                        completion(.failure(error))
                    }
                } else {
//                    completion(.failure(.invalidData))
                    completion(.failure(error!))
                }
            } else {
//                completion(.failure(.responseUnsuccessful))
                completion(.failure(error!))
            }
        }.resume()
    }
    
    func fetchRestaurantImage(with Url: URL, completion: @escaping (Result<UIImage, APIError>) -> Void) {
//        session.dataTask(with: Url) { data, response, error in
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.requestFailed))
//                return
//            }
//            if httpResponse.statusCode == 200 {
//                if let data = data {
//                    if let image = UIImage(data: data) {
//                        OperationQueue.main.addOperation {
//                        completion(.success(image))
//                        }
//                    } else {
//                        completion(.failure(.downloadImageFailed))
//                    }
//                } else {
//                    completion(.failure(.invalidData))
//                }
//            } else {
//                completion(.failure(.responseUnsuccessful))
//            }
//        }.resume()
        let request = URLRequest(url: Url)
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    if let image = UIImage(data: data) {
                        OperationQueue.main.addOperation {
                        completion(.success(image))
                        }
                    } else {
                        completion(.failure(.downloadImageFailed))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                completion(.failure(.responseUnsuccessful))
            }
        }.resume()
    }
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case downloadImageFailed
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .downloadImageFailed: return "Can'not Download Image "
        }
    }
}
