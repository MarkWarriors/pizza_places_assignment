//
//  PPWeatherApiHandler.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import GoogleMaps

class PPApiHandler {
    
    private let environment: PPEnvironment
    private let sessionManager : SessionManager

    init(environment: PPEnvironment) {
        self.environment = environment
        let sessionConfig = URLSessionConfiguration.default
        self.sessionManager = SessionManager.init(configuration: sessionConfig)
    }
    
    fileprivate var resturantsListUri : URL {
        return URL(string: self.environment.baseUrl + "pizzaplaces")!
    }
    
    fileprivate var friendsListUri : URL {
        return URL(string: self.environment.baseUrl + "friends")!
    }
    
    fileprivate func resturantsDetailUri(resturandId: String) -> URL {
        return URL(string: self.environment.baseUrl + "pizzaplaces/" + resturandId)!
    }
    
    func getResturantsList(position: GMSCameraPosition) -> Observable<[PPResturant]> {
        return Observable.create { (observer) -> Disposable in
            self.sessionManager.request(self.resturantsListUri, method: .get)
                .validate()
                .responseData { (response) in
                    switch (response.result) {
                    case .success:
                        let data = try? JSONDecoder().decode(PPResturantListResponse.self, from: response.data ?? Data())
                        if let places = data?.list.places {
                            observer.onNext(places)
                            observer.onCompleted()
                        }
                        else {
                            observer.onError(PPError(localizedDescription: PPStrings.Errors.unknownError))
                        }
                        break
                    case .failure:
                        // TODO: improve errors from status code
                        observer.on(.error(PPError(localizedDescription: PPStrings.Errors.invalidRequest)))
                        break
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func getFriendsList() -> Observable<[PPFriend]> {
        return Observable.create { (observer) -> Disposable in
            self.sessionManager.request(self.friendsListUri, method: .get)
                .validate()
                .responseData { (response) in
                    switch (response.result) {
                    case .success:
                        let friends = try? JSONDecoder().decode(PPFriendResponse.self, from: response.data ?? Data())
                        if let friends = friends {
                            observer.on(.next(friends))
                            observer.on(.completed)
                        }
                        else {
                            observer.on(.error(PPError(localizedDescription: PPStrings.Errors.unknownError)))
                        }
                        break
                    case .failure:
                        // TODO: improve errors from status code
                        observer.on(.error(PPError(localizedDescription: PPStrings.Errors.invalidRequest)))
                        break
                    }
            }
            
            return Disposables.create()
        }
    }

    func downloadImage(uri: URL) -> Observable<UIImage?> {
        return Observable.create { (observer) -> Disposable in
            self.sessionManager.request(uri, method: .get)
                .validate()
                .responseData { (response) in
                    switch (response.result) {
                    case .success:
                        if let data = response.data, let image = UIImage(data: data) {
                            observer.on(.next(image))
                            observer.on(.completed)
                        }
                        else {
                            observer.on(.error(PPError(localizedDescription: PPStrings.Errors.unknownError)))
                        }
                        break
                    case .failure:
                        // TODO: improve errors from status code
                        observer.on(.error(PPError(localizedDescription: PPStrings.Errors.invalidRequest)))
                        break
                    }
            }
            
            return Disposables.create()
        }
    }
    
}
