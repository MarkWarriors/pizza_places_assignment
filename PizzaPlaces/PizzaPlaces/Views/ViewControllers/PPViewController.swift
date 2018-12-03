//
//  PPViewController.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit

class PPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func showAlertFor(error: PPError){
        let alert = UIAlertController.init(title: PPStrings.Commons.error, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        
        let okBtn = UIAlertAction.init(title: PPStrings.Commons.ok, style: UIAlertAction.Style.default)
        
        alert.addAction(okBtn)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

