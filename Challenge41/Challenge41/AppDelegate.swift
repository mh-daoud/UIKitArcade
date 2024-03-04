//
//  AppDelegate.swift
//  Challenge41
//
//  Created by Mac on 04/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }

    


}

