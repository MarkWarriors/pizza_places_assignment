//
//  PPStrings.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation

struct PPStrings {
    
    struct Segues {
        public static let mainToDetails = "mainToDetails"
    }
    
    
    struct Buttons {
        public static let readMore = "Read more".localized
        public static let readLess = "Read less".localized
    }
    
    // MARK: Common Strings
    struct Commons {
        public static let loading = "Loading".localized
        public static let ok = "Ok".localized
        public static let error = "Error".localized
        public static let unknown = "unknown".localized
    }
    
    struct Errors {
        // MARK: Errors Strings
        public static let errorGeneric = "An error occurred".localized
        public static let unknownError = "Unknown Error".localized
        public static let cityNotFoundError = "City not found".localized
        public static let connectionError = "Connection Error".localized
        public static let invalidCredentials = "Invalid Credentials".localized
        public static let invalidRequest = "Invalid Request".localized
        public static let notFound = "Not Found".localized
        public static let invalidResponse = "Invalid Response".localized
        public static let serverError = "Server Error".localized
        public static let serverUnavailable = "Server Unavailable".localized
        public static let timeOut = "TimeOut".localized
        public static let unsuppotedURL = "UnsuppotedURL".localized
    }
}
    
