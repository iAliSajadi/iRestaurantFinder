//
//  LocationPermissionViewController.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit

class LocationPermissionViewController: UIViewController {

    @IBOutlet weak var locationPermissionView: LocationPermissionView!
    
    var locationService: LocationService?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationPermissionView.didTapAllow = { [weak self] in
            self?.locationService?.requestLocationAuthorization()
        }
        
        locationService?.didChangeStatus = { [weak self] result in
            if result {
                self?.locationService?.getLocation()
            }
        }
        
        locationService?.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                print(location)
            case .failure(let error):
                assertionFailure("Error getting the location \(error)")
            }
        }
    }
}
