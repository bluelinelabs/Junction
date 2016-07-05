//
//  AppDelegate.swift
//  WaveExample
//
//  Created by Jimmy McDermott on 6/28/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import UIKit
import Wave

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        window = WaveWindow(frame: UIScreen.mainScreen().bounds, style: .RightDrawer, sections: [Section()], enabled: true)
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()
        
        return true
    }
}

