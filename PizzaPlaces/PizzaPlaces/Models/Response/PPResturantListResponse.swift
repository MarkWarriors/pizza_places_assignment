//
//  PPResturantListResponse.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//


import Foundation

struct PPResturantListResponse: Codable {
    let meta: Meta
    let list: List
}

struct List: Codable {
    let places: [PPResturant]
}

struct Image: Codable {
    let id: String
    let url: String
    let caption: String
    let expiration: String
}

struct Meta: Codable {
    let total, precision: Int
}
