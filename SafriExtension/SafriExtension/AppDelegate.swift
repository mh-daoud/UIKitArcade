//
//  AppDelegate.swift
//  SafriExtension
//
//  Created by admin on 23/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = ViewController()
        return true
    }


}

