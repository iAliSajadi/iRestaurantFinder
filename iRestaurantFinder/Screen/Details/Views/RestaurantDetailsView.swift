//
//  RestaurantDetailsViewController.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/24/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class RestaurantDetailsView: BaseView {

    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var hoursLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var ratingsLabel: UILabel?
    @IBOutlet weak var mapView: MKMapView?

    @IBAction func handlePageControl(_ sender: UIPageControl) {
    }
}
