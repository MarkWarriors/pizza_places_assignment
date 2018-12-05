//
//  PPMainVC.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps
import RxGoogleMaps

class PPMainVC: PPViewController, ViewModelBased, GMSMapViewDelegate {
    typealias ViewModel = PPMainViewModel
    
    var viewModel: PPMainViewModel?
    var mapView : GMSMapView?
    
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var navSearchBtn: UIButton!
    @IBOutlet weak var navPizzaBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMap()
        bindViewModel()
    }
    
    func setupMap(){
        // we can obviously use the user position, but for this demo I decided to use Amsterda as fix location
        let camera = GMSCameraPosition.camera(withLatitude: 52.379189, longitude: 4.899431, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: self.mapContainer.bounds, camera: camera)
        
        if mapView != nil {
            mapView!.delegate = self
            self.mapContainer.addSubview(mapView!)
        }
    }
    
    
    func bindViewModel() {
        let viewWillAppear =  self.rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map({ _ -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        let mapChange = mapView?.rx.idleAt.asDriver()
        let poiTapped = mapView?.rx.didTapAtPoi.asDriver()
        
        viewModel!.initBindings(viewWillAppear: viewWillAppear,
                                loadPlaces: mapChange,
                                poiTapped: poiTapped)
        
        viewModel!.error.subscribe(onNext: { (error) in
            self.showAlertFor(error: error)
        })
        .disposed(by: self.disposeBag)
        
        viewModel!.markerList.subscribe(onNext: { (markers) in
            // we can think to use an array of current marker to avoid the "clear all then put markers that previously already exists
            self.mapView?.clear()
            markers
                .forEach({ (marker) in
                    marker.isTappable = true
                    //maybe we can change the scale of the marker
                    marker.icon = PPImages.Marker.icon
                    marker.map = self.mapView
            })
        })
        .disposed(by: self.disposeBag)
        
        navSearchBtn.rx.tap.asDriver().drive(onNext: { (_) in
            self.performSegue(withIdentifier: "toPizzaDetails", sender: self)
        })
        .disposed(by: self.disposeBag)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        return true
    }
    
}
