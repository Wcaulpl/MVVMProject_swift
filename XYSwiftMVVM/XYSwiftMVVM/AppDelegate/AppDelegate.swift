//
//  AppDelegate.swift
//  XYSwiftMVVM
//
//  Created by Wcaulpl on 2019/6/13.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = XYTabBarController()
        return true
    }

}

