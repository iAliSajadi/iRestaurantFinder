//
//  FoodCategoryCell.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit

class RestaurantsCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var markerImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
//    var restaurantImageUrl: String!
//    var yelpClient: YelpClient!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getRestaurantImage(with imageUrl: URL , yelpClient: YelpClient) {
//        guard let url = imageUrl else { return }
        yelpClient.getRestaurantImage(with: imageUrl) { (result) in
            switch result {
            case .success(let image):
                self.restaurantImageView.image = image
            case .failure:
                print(APIError.downloadImageFailed)
            }
        }
    }
    
    func setupImageView() {
        restaurantImageView.layer.cornerRadius = 15
    }
    
    func configure(viewModel: RestaurantsViewModel) {
        self.restaurantNameLabel.text = viewModel.name
        self.distanceLabel.text = viewModel.formattedDistance!  + " km"
    }
}
