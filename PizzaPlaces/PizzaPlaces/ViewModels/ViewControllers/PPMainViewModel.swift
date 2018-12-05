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
    
    private let privateResturantsList = PublishRelay<[PPResturant]>()
    public var resturantsList : Observable<[PPResturant]> {
        return self.privateResturantsList.asObservable()
    }
    
    private let privateResturantDetail = PublishRelay<PPResturant>()
    public var resturantDetail : Observable<PPResturant> {
        return self.resturantDetail.asObservable()
    }
    
    init(apiHandler: PPApiHandler) {
        self.apiHandler = apiHandler
    }
    
    public func initBindings(viewWillAppear: Driver<Void>,
                             loadPlaces: Driver<(GMSCameraPosition)>?,
                             poiTap: Driver<(placeId: String, name: String, location: CLLocationCoordinate2D)>?){
        
        loadPlaces?
            .asObservable()
            .flatMap{ self.apiHandler.getResturantsList(position: $0) }
            .catchError({ (error) -> Observable<[PPResturant]> in
                self.privateError.accept(error as! PPError)
                return Observable.error(error)
            })
            .retry()
            .bind(to: self.privateResturantsList)
        .disposed(by: self.disposeBag)
    
    }
    
    
    
}
