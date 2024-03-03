//
//  AppDelegate.swift
//  Challenge23
//
//  Created by Mac on 29/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
       // let nc = UINavigationController(rootViewController: DetailsViewController())
        let nc = UINavigationController(rootViewController: CountriesTableViewController())
        window?.rootViewController = nc
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }

}

