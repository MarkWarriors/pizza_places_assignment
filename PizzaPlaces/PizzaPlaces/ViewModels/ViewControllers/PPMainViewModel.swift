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
    
    private var privateSelectedResturant : PPResturant?
    private var resturantList : [PPResturant] = []
    
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
                             loadPlaces: Driver<(GMSCameraPosition)>?){
        
        loadPlaces?
            .asObservable()
            .flatMap{ self.apiHandler.getResturantsList(position: $0) }
            .catchError({ [weak self] (error) -> Observable<[PPResturant]> in
                if let self = self {
                    self.privateError.accept(error as! PPError)
                }
                return Observable.error(error)
            })
            .retry()
            .map({ [weak self] (resturants) -> [PPMarker] in
                if let self = self {
                    self.resturantList = resturants
                }
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
    
    public func userDidTapMarkerInfoWindow(marker: PPMarker){
        let resturant = self.resturantList.filter{ $0.id == marker.id }.first
        if resturant != nil {
            self.privateSelectedResturant = resturant
            self.privateRequestSegue.accept(PPStrings.Segues.mainToDetails)
        }
        else {
            self.privateError.accept(PPError.init(localizedDescription: PPStrings.Errors.errorGeneric))
        }
    }
    
    public func prepare(_ segue: inout UIStoryboardSegue) {
        if segue.identifier == PPStrings.Segues.mainToDetails, let vc = segue.destination as? PPPizzaDetailsVC, let resturant = privateSelectedResturant {
            vc.viewModel = PPPizzaDetailsViewModel(apiHandler: self.apiHandler,
                                                   resturant: resturant)
        }
        else {
            self.privateError.accept(PPError.init(localizedDescription: PPStrings.Errors.errorGeneric))
        }
    }
    
}
