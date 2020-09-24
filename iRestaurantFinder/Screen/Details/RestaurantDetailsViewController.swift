//
//  RestaurantDetailsViewController.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {
    
    @IBOutlet weak var restaurantDetailsView: RestaurantDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Avenir Next", size: 30)!]
    }

}
