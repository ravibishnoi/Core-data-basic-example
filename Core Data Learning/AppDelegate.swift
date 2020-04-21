//
//  AppDelegate.swift
//  Core Data Learning
//
//  Created by AshutoshD on 26/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = DataViewController(persistenceManager: PersistanceManager.shared)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }



    // MARK: - Core Data stack

  

}

