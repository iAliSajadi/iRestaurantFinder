//
//  RestaurantCategoryTableViewController.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit

protocol RestaurantsTableViewDelegate: class {
    func didTapCell(_ viewModel: RestaurantsViewModel)
}

class RestaurantsTableViewController: UITableViewController {

    let identifier = "restaurantsCell"
    weak var delegate: RestaurantsTableViewDelegate!
    var yelpClient: YelpClient!
    
    var viewModels = [RestaurantsViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont(name: "AvenirNext-Bold", size: 30)!, .foregroundColor: UIColor.red]

        navigationItem.title = "Restaurants"
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "RestaurantsCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RestaurantsCell

        let viewModel = viewModels[indexPath.row]
        cell.getRestaurantImage(with: viewModel.imageUrl, yelpClient: yelpClient)
        cell.configure(viewModel: viewModel)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewModel = viewModels[indexPath.row]
        delegate.didTapCell(viewModel)
        
        navigationController!.pushViewController(RestaurantDetailsViewController(), animated: true)

    }
}

//extension RestaurantsTableViewController: SceneDelegateAction {
//    func didPushTo(_ restaurantsNavigation: UINavigationController) {
//        <#code#>
//    }
//}
