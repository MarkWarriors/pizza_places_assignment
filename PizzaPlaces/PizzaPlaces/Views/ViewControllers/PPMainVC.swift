//
//  PPMainVC.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import GoogleMaps

class PPMainVC: PPViewController, ViewModelBased, GMSMapViewDelegate {
    typealias ViewModel = PPMainViewModel
    
    var viewModel: PPMainViewModel?
    
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var navSearchBtn: UIBarButtonItem!
    @IBOutlet weak var navPizzaBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMap()
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
    
    func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude: 52.2827, longitude: 4.6819, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: self.mapContainer.bounds, camera: camera)
        mapView.delegate = self
        self.mapContainer.addSubview(mapView)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
    }
    
}
