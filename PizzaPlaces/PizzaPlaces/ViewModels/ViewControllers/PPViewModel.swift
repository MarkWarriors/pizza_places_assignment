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
    
    private let privateIsLoading = PublishRelay<Bool>()
    private let privateError = PublishRelay<(PPError)>()
    
    
    var isLoading : Observable<Bool> {
        return self.privateIsLoading.asObservable()
    }
    
    var error : Observable<PPError> {
        return self.privateError.asObservable()
    }
    
}
