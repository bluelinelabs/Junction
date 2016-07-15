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
        
        let secondSection = StringMultipleSelectionSetting(possibleValues: ["google.com", "yahoo.com"], enableCustom: true, name: "Single Selection String", key: "singleSelectionString", defaultIndex: 0)
        
        Junction.sections = [firstSection, secondSection]
        Junction.style = .Shake
        Junction.completionBlock = { previousValues, newValues in
            print(previousValues)
            print(newValues)
        }
        
        window = Junction.createWindow(UIScreen.mainScreen().bounds, debugMode: true)
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()

        return true
    }
}
