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
        let sessionConfig = URLSessionConfiguration.default
        self.sessionManager = SessionManager.init(configuration: sessionConfig)
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
    
    public func getResturantsList(callback: (([PPResturant]?, PPError?)->())?){
        self.sessionManager.request(self.resturantsListUri, method: .get)
            .validate()
            .responseData { (response) in
                switch (response.result) {
                case .success:
                    let data = try? JSONDecoder().decode(PPResturantListResponse.self, from: response.data ?? Data())
                    if let data = data {
                        callback?(data.list.places, nil)
                    }
                    else {
                        callback?(nil, PPError(localizedDescription: PPStrings.Errors.unknownError))
                    }
                    break
                case .failure:
                    // TODO: improve errors from status code
                    callback?(nil, PPError(localizedDescription: PPStrings.Errors.invalidRequest))
                    break
                }
        }
    }
    
    public func getFriendsList(callback: (([PPFriend]?, PPError?)->())?){
        self.sessionManager.request(self.friendsListUri, method: .get)
            .validate()
            .responseData { (response) in
                switch (response.result) {
                case .success:
                    let data = try? JSONDecoder().decode(PPFriendResponse.self, from: response.data ?? Data())
                    if let data = data {
                        callback?(data, nil)
                    }
                    else {
                        callback?(nil, PPError(localizedDescription: PPStrings.Errors.unknownError))
                    }
                    break
                case .failure:
                    // TODO: improve errors from status code
                    callback?(nil, PPError(localizedDescription: PPStrings.Errors.invalidRequest))
                    break
                }
        }
    }
    
}
