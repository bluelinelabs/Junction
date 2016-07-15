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
        let stringSetting = StringSetting(placeholder: "", defaultValue: nil, key: "mainEndpoint", value: "https://www.google.com", title: "Main Endpoint:")
        let intSetting = IntSetting(defaultValue: nil, value: 8080, key: "port", title: "Port")
        
        let firstSection = Section(name: "Endpoints")
            .addRow(stringSetting)
            .addRow(intSetting)
        
        let secondSection = StringSingleSelectionSection(possibleValues: ["google.com", "yahoo.com"], enableCustom: true, name: "Single Selection String", key: "singleSelectionString", defaultValue: 0)
        
        let junction = Junction()
        junction.enabled = true
        junction.sections = [firstSection, secondSection]
        junction.style = .Shake
        
        window = junction.createWindow(UIScreen.mainScreen().bounds)
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()

        return true
    }
}

