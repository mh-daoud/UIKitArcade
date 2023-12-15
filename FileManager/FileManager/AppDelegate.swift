//
//  AppDelegate.swift
//  FileManager
//
//  Created by admin on 15/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    var navigationController : UINavigationController! = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        navigationController = UINavigationController(rootViewController: FilesExplorer())
        window?.rootViewController = navigationController
        return true
    }
    
}

