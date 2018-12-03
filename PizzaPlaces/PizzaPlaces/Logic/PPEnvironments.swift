//
//  PPEnvironments.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation

class PPEnvironment {
    let baseUrl : String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}

class PPEnvironments {
    public static let testEnv = PPEnvironment(baseUrl: "https://pizzaplaces.free.beeceptor.com/")
    public static let productionEnv = PPEnvironment(baseUrl: "https://pizzaplaces.free.beeceptor.com/")
}


