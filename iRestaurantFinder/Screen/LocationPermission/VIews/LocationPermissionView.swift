//
//  PermissionViewController.swift
//  iRestaurantFinder
//
//  Created by Ali Sajadi on 9/23/20.
//  Copyright © 2020 Ali Sajadi. All rights reserved.
//

import UIKit

@IBDesignable class LocationPermissionView: BaseView {

    @IBOutlet weak var allowButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!
    
    var didTapAllow: (() -> Void)?
    
    @IBAction func didTapaAllowButon(_ sender: UIButton) {
        didTapAllow?()
    }
    
    @IBAction func didTapDenyButton(_ sender: UIButton) {
    }
}
