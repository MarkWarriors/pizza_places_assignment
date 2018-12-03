//
//  PPStrings.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation

struct PPStrings {
    
    // MARK: Common Strings
    struct Commons {
        public static let loading : String = "Loading".localized
        public static let ok : String = "Ok".localized
        public static let error : String = "Error".localized
        public static let unknown : String = "unknown".localized
    }
    
    struct Errors {
        // MARK: Errors Strings
        public static let errorGeneric : String = "An error occurred".localized
        public static let unknownError : String = "Unknown Error".localized
        public static let cityNotFoundError : String = "City not found".localized
        public static let connectionError : String = "Connection Error".localized
        public static let invalidCredentials : String = "Invalid Credentials".localized
        public static let invalidRequest : String = "Invalid Request".localized
        public static let notFound : String = "Not Found".localized
        public static let invalidResponse : String = "Invalid Response".localized
        public static let serverError : String = "Server Error".localized
        public static let serverUnavailable : String = "Server Unavailable".localized
        public static let timeOut : String = "TimeOut".localized
        public static let unsuppotedURL : String = "UnsuppotedURL".localized
    }
}
    
