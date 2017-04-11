//
//  AppDelegate.swift
//  2048
//
//  Created by Sai on 10/04/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = GameViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication)
    {
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication)
    {
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication)
    {
    }
    
    
    func applicationWillTerminate(_ application: UIApplication)
    {
    }
}
