//
//  AppDelegate.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let firstViewController = DrasboardViewController.init(nibName: "DrasboardViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: firstViewController)
        navigationController.navigationBar.isHidden = true
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController
        return true
    }
    
}

