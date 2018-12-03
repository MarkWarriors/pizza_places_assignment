//
//  PPMainVC.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import GoogleMaps

class PPMainVC: PPViewController, ViewModelBased {
    typealias ViewModel = PPMainViewModel
    
    var viewModel: PPMainViewModel?
    
    @IBOutlet weak var mapContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() {
        
    }
    
}
