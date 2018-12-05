//
//  PPMainViewModel.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps

class PPMainViewModel : PPViewModel {
    
    private let apiHandler : PPApiHandler
    
    private let privateMarkerList = BehaviorRelay<[PPMarker]>(value: [])
    public var markerList : Observable<[PPMarker]> {
        return self.privateMarkerList.asObservable()
    }
    
    private let privateResturantDetail = PublishRelay<PPResturant>()
    public var resturantDetail : Observable<PPResturant> {
        return self.privateResturantDetail.asObservable()
    }
    
    init(apiHandler: PPApiHandler) {
        self.apiHandler = apiHandler
    }
    
    public func initBindings(viewWillAppear: Driver<Void>,
                             loadPlaces: Driver<(GMSCameraPosition)>?,
                             poiTapped: Driver<(placeId: String, name: String, location: CLLocationCoordinate2D)>?){
        
        loadPlaces?
            .asObservable()
            .flatMap{ self.apiHandler.getResturantsList(position: $0) }
            .catchError({ (error) -> Observable<[PPResturant]> in
                self.privateError.accept(error as! PPError)
                return Observable.error(error)
            })
            .retry()
            .map({ (resturants) -> [PPMarker] in
                var markerList = [PPMarker]()
                resturants
                    .filter{ $0.coordinates != nil }
                    .forEach({ (resturant) in
                        let marker = PPMarker.init(resturant: resturant)
                        markerList.append(marker)
                })
                return markerList
            })
            .bind(to: self.privateMarkerList)
        .disposed(by: self.disposeBag)
    
    }
    
    
    
}
