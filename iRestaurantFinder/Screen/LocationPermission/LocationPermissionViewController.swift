//
//  LocationPermissionViewController.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit

protocol LocationPermissionDelegate: class {
    func didTapAllow()
}

class LocationPermissionViewController: UIViewController {

    @IBOutlet weak var locationPermissionView: LocationPermissionView!
    
    weak var delegate: LocationPermissionDelegate?
    var locationManager: LocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = LocationManager()
        
        
        locationPermissionView.didTapAllow = {
            self.delegate?.didTapAllow()
        }
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}
