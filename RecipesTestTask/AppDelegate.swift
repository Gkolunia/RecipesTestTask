//
//  AppDelegate.swift
//  RecipesTestTask
//
//  Created by Hrybenuik Mykola on 8/9/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // Check arguments from UI Test target.
        let args = ProcessInfo.processInfo.arguments
        if args.contains(LaunchConstants.testModeReset) {
            UserSessionManager.shared.logout()
        }
        else if args.contains(LaunchConstants.testModeSigned) {
            UserSessionManager.shared.signIn(with: UserCredentials(TestUserCredentials.email, TestUserCredentials.password),
                                             completionHandler: { (result) in
                                                
            })
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window!)
        appCoordinator.start(with: UserSessionManager.shared)

        return true
    }
    
}

