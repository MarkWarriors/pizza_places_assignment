//
//  PPResturant.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation
import CoreLocation

struct PPResturant: Codable, Hashable {
    static func == (lhs: PPResturant, rhs: PPResturant) -> Bool {
        return lhs.id == rhs.id
    }
    
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
    var hashValue : Int {
        return id.hashValue
    }
    
    var coordinates : CLLocationCoordinate2D? {
        return CLLocationCoordinate2D.init(latitude: self.latitude, longitude: self.longitude)
    }
    
    public func isOpenString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let today = formatter.string(from: date).lowercased()
        
        // todo check between dates if is open, not only from string
        if let opening = self.openingHours.filter({ $0.lowercased().starts(with: today) }).first {
            return opening.contains("closed") ? PPStrings.Commons.closed : PPStrings.Commons.open
        }
        return ""
    }
}
