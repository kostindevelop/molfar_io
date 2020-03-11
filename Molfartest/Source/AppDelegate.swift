//
//  AppDelegate.swift
//  Molfartest
//
//  Created by Konstantin Igorevich on 27.02.2020.
//  Copyright © 2020 Konstantin Igorevich. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StorageService.shared.generateRandomObject()
        return true
    }
}

