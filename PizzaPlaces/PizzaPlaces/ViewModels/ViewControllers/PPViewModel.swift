//
//  PPViewModel.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 04/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PPViewModel {
    
    let disposeBag = DisposeBag()
    
    internal let privateRequestSegue = PublishRelay<String>()
    var requestSegue : Observable<String> {
        return self.privateRequestSegue.asObservable()
    }
    
    internal let privateIsLoading = PublishRelay<Bool>()
    var isLoading : Observable<Bool> {
        return self.privateIsLoading.asObservable()
    }
    
    internal let privateError = PublishRelay<(PPError)>()
    var error : Observable<PPError> {
        return self.privateError.asObservable()
    }
    
}
