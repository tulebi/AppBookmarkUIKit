//
//  AppDelegate.swift
//  fullAppBookmarkUIKit
//
//  Created by Тулеби Берик on 07.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
       
        if !UserDefaults.standard.bool(forKey: "HasLaunchedBefore") {
                UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
            window?.rootViewController = UINavigationController(rootViewController: ViewController())
        } else if !UserDefaults.standard.bool(forKey: "FirstBookmark") {
                window?.rootViewController = UINavigationController(rootViewController: SecondViewController())
            }
        else {
            window?.rootViewController = UINavigationController(rootViewController: TableView())
        }
            
        return true
    }


}

