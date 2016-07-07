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
        
        let stringSetting = StringSetting(placeholder: "", defaultValue: nil, key: "mainEndpoint", value: "https://www.google.com", title: "Main Endpoint:")
        let intSetting = IntSetting(defaultValue: nil, value: 8080, key: "port", title: "Port")
        
        let firstSection = Section(name: "Endpoints")
        .addRow(stringSetting)
        .addRow(intSetting)
        
        let thirdSection = StringSingleSelectionSection(possibleValues: ["google.com", "yahoo.com"], enableCustom: false, name: "Single Selection String")
        let fourthSection = IntSingleSelectionSetting(possibleValues: [1, 2, 3, 4], enableCustom: true, name: "Single Selection Int")
        
        window = WaveWindow(frame: UIScreen.mainScreen().bounds, style: .RightDrawer, sections: [firstSection, thirdSection], enabled: true)
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()
        
        return true
    }
}
