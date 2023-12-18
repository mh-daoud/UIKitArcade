//
//  AppDelegate.swift
//  PetitionBrowser
//
//  Created by admin on 18/12/2023.
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
        
        let tabBar = UITabBarController()
        let tab1 = UINavigationController(rootViewController: PetitionTableViewController())
        tab1.tabBarItem = UITabBarItem(title: "Petitions", image: UIImage(systemName: "tag.fill"), tag: 0)
        let tab2 = UINavigationController(rootViewController: PetitionTableViewController())
        tab2.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        
        tabBar.viewControllers = [tab1, tab2]
        
        window?.rootViewController = tabBar
        return true
    }


}

