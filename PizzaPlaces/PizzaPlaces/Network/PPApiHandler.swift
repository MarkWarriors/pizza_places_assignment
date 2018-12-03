//
//  PPWeatherApiHandler.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation
import Alamofire

class PPApiHandler {
    
    private let environment: PPEnvironment
    private let sessionManager : SessionManager

    init(environment: PPEnvironment) {
        self.environment = environment
        self.sessionManager = SessionManager.init()
    }
    
    fileprivate var resturantsListUri : URL {
        return URL(string: self.environment.baseUrl + "pizza")!
    }
    
    fileprivate var friendsListUri : URL {
        return URL(string: self.environment.baseUrl + "friends")!
    }
    
    fileprivate func resturantsDetailUri(resturandId: String) -> URL {
        return URL(string: self.environment.baseUrl + "pizza/" + resturandId)!
    }
    
    public func getResturantsList(callback: ((Any?, PPError?)->())?){
        self.sessionManager.request(self.resturantsListUri, method: .get)
            .validate()
            .responseData { (response) in
                switch (response.result) {
                case .success:
                    break
                case .failure:
                    // TODO: improve errors from status code
                    callback?(nil, PPError(localizedDescription: PPStrings.Errors.invalidRequest))
                    break
                }
        }
    }
    
}
