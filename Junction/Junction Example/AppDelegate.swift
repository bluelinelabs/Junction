//
//  AppDelegate.swift
//  Junction Example
//
//  Created by Jimmy McDermott on 7/13/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit
import Junction

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Junction.settingsUpdatedBlock = { previousValues, newValues in
            print(previousValues)
            print(newValues)
        }
        
        window = Junction.createWindow(UIScreen.mainScreen().bounds, setup: ExampleJunctionSetup())
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()

        return true
    }
}
