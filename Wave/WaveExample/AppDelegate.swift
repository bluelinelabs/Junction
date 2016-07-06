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
        
        let secondSection = Section(name: "Second Section")
        .addRow(intSetting)
        .addRow(stringSetting)
        
        let thirdSection = SingleSelectionSection(possibleValues: ["endpoint 1", "endpoint 2"], enableCustom: false, customOption: nil, name: "Single Selection")
        
        window = WaveWindow(frame: UIScreen.mainScreen().bounds, style: .RightDrawer, sections: [firstSection, secondSection, thirdSection], enabled: true)
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()
        
        return true
    }
}
