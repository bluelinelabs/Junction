//
//  AppDelegate.swift
//  WaveExample
//
//  Created by Jimmy McDermott on 6/28/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit
import Wave

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let section = Section(name: "Endpoints")
        .addRow(StringSetting(placeholder: "", defaultValue: "", key: "", value: "http://www.healthipass.com/api/v2/", title: "Main Endpoint:"))
        
        window = WaveWindow(frame: UIScreen.mainScreen().bounds, style: .RightDrawer, sections: [section], enabled: true)
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()
        
        return true
    }
}
