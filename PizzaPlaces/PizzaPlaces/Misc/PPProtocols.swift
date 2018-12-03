//
//  Protocols.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit

public protocol ViewModelBased where Self: UIViewController {
    associatedtype ViewModel
    var viewModel : ViewModel? { get set }
    
    func bindViewModel()
}

public protocol CellViewModelBased where Self: UITableViewCell {
    associatedtype ViewModel
    var viewModel : ViewModel? { get set }
}
