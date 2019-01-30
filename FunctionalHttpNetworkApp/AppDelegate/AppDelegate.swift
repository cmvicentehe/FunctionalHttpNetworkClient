//
//  AppDelegate.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 10/1/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import UIKit
import FunctionalHttpClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.showHome()
        self.initializeLogs()
        return true
    }

    private func showHome() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        guard let windowNotNil = self.window else { return }
        let homeWireframe = HomeWireframe(window: windowNotNil)
        homeWireframe.showTabBar()
    }

    private func initializeLogs() {
        Logger.shared.logLevel = .debug
    }
}
