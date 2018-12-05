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
    
    internal let privateIsLoading = PublishRelay<Bool>()
    internal let privateError = PublishRelay<(PPError)>()
    
    
    var isLoading : Observable<Bool> {
        return self.privateIsLoading.asObservable()
    }
    
    var error : Observable<PPError> {
        return self.privateError.asObservable()
    }
    
}
