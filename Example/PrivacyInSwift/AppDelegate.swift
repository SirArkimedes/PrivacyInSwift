//
//  AppDelegate.swift
//  PrivacyInSwift
//
//  Created by Andrew Robinson on 04/11/2020.
//  Copyright (c) 2020 Andrew Robinson. All rights reserved.
//

import UIKit
import PrivacyInSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Privacy.start(productionApiKey: "", sandboxApiKey: "5871733b-3c96-4fac-bed7-4fa9cdc572c4")
        Privacy.environment = .sandbox
        return true
    }
}

