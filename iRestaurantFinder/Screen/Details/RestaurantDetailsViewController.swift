//
//  RestaurantDetailsViewController.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {
    
    @IBOutlet weak var restaurantDetailsView: RestaurantDetailsView?

    var viewModel: RestaurantDetailsViewModel? {
        didSet {
            configViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Avenir Next", size: 30)!]
    }
    
    func configViews() {
        if let viewModel = viewModel {
            restaurantDetailsView?.hoursLabel?.text = viewModel.isOpen
            restaurantDetailsView?.locationLabel?.text = viewModel.phoneNumber
            restaurantDetailsView?.ratingsLabel?.text = viewModel.rating
        }
    }

}
