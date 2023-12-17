//
//  AppDelegate.swift
//  AnagramGame
//
//  Created by admin on 16/12/2023.
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
        window?.rootViewController = UINavigationController(rootViewController: AnagramWordsViewController())
        return true
    }


}

