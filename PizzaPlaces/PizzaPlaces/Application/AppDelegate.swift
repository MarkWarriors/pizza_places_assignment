//
//  AppDelegate.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(PPApiKey.googleMapsKey)
        
        let mainSB = UIStoryboard.init(name: "Main", bundle: nil)
        let navigationController = mainSB.instantiateInitialViewController() as? UINavigationController
        let navigationBar = navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backIndicatorImage = PPImages.Navigation.backButton
        navigationBar.backIndicatorTransitionMaskImage = PPImages.Navigation.backButton

        let mainVC = navigationController?.viewControllers.first as? PPMainVC
        mainVC?.viewModel = PPMainViewModel.init(apiHandler: PPApiHandler.init(environment: PPEnvironments.testEnv))
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()        
        return true
    }

   

}

