//
//  SceneDelegate.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/23/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit
import CoreLocation

//protocol SceneDelegateAction {
//    func didPushTo(_ restaurantsNavigation: UINavigationController)
//}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let locationManager = LocationManager()
    let yelpClient = YelpClient()
    var viewModels = [RestaurantsViewModel]()
    
    let locationPermissionNavigation = UINavigationController(rootViewController: LocationPermissionViewController())
    let restaurantsNavigation = UINavigationController(rootViewController: RestaurantsTableViewController())

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow()
        window?.windowScene = windowScene
        
        
        locationManager.didChangeStatus = { [weak self] result in
            if result {
                self?.locationManager.getLocation()
            }
        }

        locationManager.newLocation = { result in
            switch result {
            case .success(let location):
                self.getAllBusiness(with: location.coordinate)
            case .failure(let error):
                assertionFailure("Error getting the location \(error)")
            }
        }
        
        switch locationManager.locationAuthorizationStatus {
        case .notDetermined, .restricted, .denied:
            let locationPermissionController = locationPermissionNavigation.topViewController as? LocationPermissionViewController
            locationPermissionController!.delegate = self
            window?.rootViewController = locationPermissionNavigation
        default:
            window?.rootViewController = restaurantsNavigation
            locationManager.getLocation()
        }
        
        window?.makeKeyAndVisible()
    }
    
    func getAllBusiness(with coordinate: CLLocationCoordinate2D) {
        
        yelpClient.search(withTerm: nil, at: .init(latitude: coordinate.latitude, longitude: coordinate.longitude)) { [weak self] (result) in
            switch result {
            case let .success(businesses):
                guard let strongSelf = self else { return }
                strongSelf.viewModels = businesses.compactMap(RestaurantsViewModel.init).sorted(by: {$0.distance < $1.distance})
                
                let restaurantsTableViewController = strongSelf.restaurantsNavigation.topViewController as? RestaurantsTableViewController
                
                restaurantsTableViewController?.viewModels = strongSelf.viewModels
                restaurantsTableViewController?.yelpClient = strongSelf.yelpClient
                restaurantsTableViewController?.delegate = self
                
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
    
    func getBusinessDetails(withId id: String) {
        yelpClient.business(withId: id) { [weak self] (result) in
            switch result {
            case .success(let details):
                guard let strongSelf = self else { return }
                print("Details: \(details)")
                
                let viewModel = RestaurantDetailsViewModel(details: details)
                let restaurantDetailsViewController = strongSelf.restaurantsNavigation.topViewController as? RestaurantDetailsViewController
                restaurantDetailsViewController?.viewModel = viewModel
                
            case .failure(let error):
                print("Dailed to get details: \(error)")
            }
        }
    }
}

extension SceneDelegate: LocationPermissionDelegate, RestaurantsTableViewDelegate {
    func didTapAllow() {
        locationManager.requestLocationAuthorization()
    }
    
    func didTapCell(_ viewModel: RestaurantsViewModel) {
        getBusinessDetails(withId: viewModel.id)
        print("didTapCell")
    }
}

