//
//  PPResturant.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation
import CoreLocation

struct PPResturant: Codable {
    let id : String
    let name : String
    let phone : String?
    let website : String?
    let formattedAddress : String?
    let city : String?
    let openingHours: [String]
    let longitude, latitude: Double
    let images: [Image]
    let friendIds: [String]
    
    var coordinates : CLLocationCoordinate2D? {
        return CLLocationCoordinate2D.init(latitude: self.latitude, longitude: self.longitude)
    }
}
