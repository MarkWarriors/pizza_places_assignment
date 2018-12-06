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

class PPMainVC: PPViewController, ViewModelBased {
    typealias ViewModel = PPMainViewModel
    
    var viewModel: PPMainViewModel?
    var mapView : GMSMapView?
    
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var navSearchBtn: UIButton!
    @IBOutlet weak var navPizzaBtn: UIButton!
    private var mapMarkers = [PPMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        bindViewModel()
    }
    
    func setupMap(){
        // we can obviously use the user position, but for this demo I decided to use Amsterda as fix location
        let camera = GMSCameraPosition.camera(withLatitude: 52.379189, longitude: 4.899431, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: self.mapContainer.bounds, camera: camera)

        if mapView != nil {
            self.mapContainer.addSubview(mapView!)
        }
        else {
            self.showAlertFor(error: PPError.init(localizedDescription: PPStrings.Errors.unknownError))
        }
    }
    
    
    func bindViewModel() {

        let viewWillAppear =  self.rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map({ _ -> Void in return () })
            .asDriver(onErrorJustReturn: ())

        let mapChange = mapView?.rx.idleAt.asDriver()
        
        viewModel!.initBindings(viewWillAppear: viewWillAppear,
                                loadPlaces: mapChange)

        viewModel!.error.subscribe(onNext: { [weak self] (error) in
            guard let self = self else { return }
            self.showAlertFor(error: error)
        })
        .disposed(by: self.disposeBag)
        
        mapView?.rx.didTapInfoWindowOf
            .asObservable()
            .bind(onNext: { [weak self]  (marker) in
                guard let self = self else {return}
                self.viewModel?.userDidTapMarkerInfoWindow(marker: marker as! PPMarker)
        })
        .disposed(by: self.disposeBag)

        viewModel!.markerList.subscribe(onNext: { [weak self] (markers) in
            // I must do this because (and i don't understand why) the Set.subtracting don't work, even if the hash are the same.
            guard let self = self else {return}
            var markerToRemove = [PPMarker]()
            self.mapMarkers.forEach({ (marker) in
                if markers.filter({ $0.id == marker.id }).count == 0 {
                    markerToRemove.append(marker)
                }
            })
            markerToRemove.forEach({ (marker) in
                marker.map = nil
                if let index = self.mapMarkers.firstIndex(of: marker) {
                    self.mapMarkers.remove(at: index)
                }
            })
            print(markerToRemove.count)
            markers
                .forEach({ (marker) in
                    marker.isTappable = true
                    //maybe we can change the scale of the marker
                    marker.icon = PPImages.Marker.icon
                    marker.map = self.mapView
                    self.mapMarkers.append(marker)
            })
        })
        .disposed(by: self.disposeBag)

        viewModel!.requestSegue.subscribe(onNext: { [weak self] (segueIdentifier) in
            guard let self = self else {return}
            self.performSegue(withIdentifier: segueIdentifier, sender: self)
        })
        .disposed(by: self.disposeBag)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var segue = segue
        self.viewModel!.prepare(&segue)
    }
}
