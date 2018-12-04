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

class PPMainViewModel : PPViewModel {
    
    private let apiHandler : PPApiHandler
    
    private let privateResturantsList = PublishRelay<PPResturant>()
    public var resturantsList : Observable<PPResturant> {
        return self.privateResturantsList.asObservable()
    }
    
    init(apiHandler: PPApiHandler) {
        self.apiHandler = apiHandler
    }
    
    public func initBindings(viewDidAppear: Driver<Void>,
                      loadPlaces: Driver<Void>
        ){
        
    }
    
}
