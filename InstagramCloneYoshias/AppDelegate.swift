//
//  AppDelegate.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //tambahan
    private var appCoordinator: AppCoordinator = .init()
    
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       //window = .init(frame: UIScreen.main.bounds)
//        if accessToken != nil {
//            window = .init(frame: UIScreen.main.bounds)
//            coordinator = .init(window: window)
//            coordinator.start()
//        }
//        else {
//            window = .init(frame: UIScreen.main.bounds)
//            window?.rootViewController = LoginViewController(viewModel: LoginViewModel())
//            //window?.makeKeyAndVisible()
//        }
        window = .init(frame: UIScreen.main.bounds)
        //appCoordinator = .init(window: window)
        window?.makeKeyAndVisible()
        appCoordinator.start(with: window)
       
        return true
    }
}


