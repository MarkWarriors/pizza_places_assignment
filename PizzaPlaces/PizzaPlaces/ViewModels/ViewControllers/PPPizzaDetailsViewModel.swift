//
//  PPPizzaDetailsViewModel.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PPPizzaDetailsViewModel : PPViewModel {
    
    private let apiHandler : PPApiHandler
    private let resturant : PPResturant
    
    private let privateResturantImage = BehaviorRelay<UIImage?>(value: nil)
    public var resturantImage : Observable<UIImage?> {
        return self.privateResturantImage.asObservable()
    }
    
    private let privateResturantName = BehaviorRelay<String>(value: "")
    public var resturantName : Observable<String> {
        return self.privateResturantName.asObservable()
    }
    
    private let privateFriendsLikes = BehaviorRelay<String>(value: "")
    public var friendsLikes : Observable<String> {
        return self.privateFriendsLikes.asObservable()
    }
    
    private let privateResturantDescription = BehaviorRelay<String>(value: "")
    public var resturantDescription : Observable<String> {
        return self.privateResturantDescription.asObservable()
    }
    
    private let privateFriendsListSource = BehaviorRelay<[PPFriend]>(value: [])
    public var friendsListSource  : Observable<[PPFriend]> {
        return self.privateFriendsListSource.asObservable()
    }
    
    init(apiHandler: PPApiHandler,
         resturant: PPResturant) {
        self.apiHandler = apiHandler
        self.resturant = resturant
    }
    
    public func initBindings(viewWillAppear: Driver<Void>){
        if let imageUri = resturant.images.first?.url,
            let url = URL(string: imageUri){
            self.apiHandler
                .downloadImage(uri: url)
                .bind(to: self.privateResturantImage)
                .disposed(by: self.disposeBag)
            
            self.privateResturantName
                .accept(self.resturant.name)
            
            self.privateFriendsLikes
                .accept("\(self.resturant.friendIds.count) \(PPStrings.ResturantDetails.friendsLikes)")
            
            //just to show something, I know that is not nice to do this string in this way
            var description = (self.resturant.formattedAddress ?? "") + "\n"
            description.append((self.resturant.phone ?? "") + "\n")
            description.append((self.resturant.website ?? "") + "\n\n" + PPStrings.ResturantDetails.openingHours
                + ": \n")
            
            self.resturant.openingHours.forEach { (hour) in
                description.append(hour + "\n")
            }
            
            
            self.privateResturantDescription
                .accept(description)
            
            self.apiHandler
                .getFriendsList()
                .subscribe(onNext: { (friendsList) in
                    let friends = friendsList.filter { self.resturant.friendIds.contains("\($0.id)") }
                    self.privateFriendsListSource.accept(friends)
                }, onError: { (error) in
                    self.privateError.accept(error as! PPError)
                })
            .disposed(by: self.disposeBag)
        }
    }
}
