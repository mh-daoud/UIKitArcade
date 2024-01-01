//
//  AppDelegate.swift
//  UIKitArcade
//
//  Created by admin on 05/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = ThemeColor.nero
        //let vc = MainAppViewController()
        //window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.clipsToBounds = true
        window?.rootViewController = UINavigationController(rootViewController: LandingPageViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

