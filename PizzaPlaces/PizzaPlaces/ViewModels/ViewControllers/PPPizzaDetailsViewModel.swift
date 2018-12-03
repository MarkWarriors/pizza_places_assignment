//
//  PPPizzaDetailsViewModel.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit

class PPPizzaDetailsViewModel {
    
    private let apiHandler : PPApiHandler
    
    private var privateErrorOccurred : PPError? {
        didSet {
            if let error = privateErrorOccurred {
                self.onErrorOccurred?(error)
            }
        }
    }
    
    private var privateOnLoading : Bool = false {
        didSet {
            self.onLoading?(privateOnLoading)
        }
    }
    
    public var onErrorOccurred : ((PPError)->())?
    public var onLoading : ((Bool)->())?
    
    init(apiHandler: PPApiHandler) {
        self.apiHandler = apiHandler
    }
    
}
