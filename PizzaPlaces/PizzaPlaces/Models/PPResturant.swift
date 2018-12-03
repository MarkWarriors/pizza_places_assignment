//
//  PPResturant.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation

struct PPResturant: Codable {
    let id, name, phone: String
    let website: String
    let formattedAddress, city: String
    let openingHours: [String]
    let longitude, latitude: Double
    let images: [Image]
    let friendIds: [String]
}
