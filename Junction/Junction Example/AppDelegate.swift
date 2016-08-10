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
        
        let multipleSelectionOptions = [MultipleChoiceOption<String>(value: "google.com", isInitialValue: true), MultipleChoiceOption<String>(value: "yahoo.com", isInitialValue: false)]
        let intMultipleSelectionOptions = [MultipleChoiceOption<Int>(value: 1, isInitialValue: true), MultipleChoiceOption<Int>(value: 2, isInitialValue: true)]
        
        let secondSection = StringMultipleChoiceSetting(possibleValues: multipleSelectionOptions, customOption: .Custom("Add Endpoint"), name: "Single Selection String", key: "singleSelectionString", isMultiSelect: false)
        let thirdSection = IntMultipleChoiceSetting(possibleValues: intMultipleSelectionOptions, customOption: .None, name: "Single Selection Int", key: "singleSelectionInt", isMultiSelect: false)
        
        Junction.sections = [firstSection, secondSection, thirdSection]
        Junction.style = .Shake
        Junction.settingsUpdatedBlock = { previousValues, newValues in
            print(previousValues)
            print(newValues)
        }
        
        window = Junction.createWindow(UIScreen.mainScreen().bounds, debugMode: true)
        window!.rootViewController = UINavigationController(rootViewController: ViewController())
        window!.makeKeyAndVisible()

        return true
    }
}
