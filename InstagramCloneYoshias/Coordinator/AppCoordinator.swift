//
//  AppCoordinator.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import RxSwift

class AppCoordinator: Coordinator {
    var viewController: UIViewController = .init()
    var mainTabBarCoordinator: MainTabBarCoordinator?
    var loginCoordinator: LoginCoordinator?
    private let disposeBag = DisposeBag()
    
    func start(with window: UIWindow?) {
        if AccessToken.current?.tokenString == nil {
            showLogin(window)
        } else {
            showTabbar(window)
        }
    }
    
    private func showLogin(_ window: UIWindow?) {
        loginCoordinator = .init()
        loginCoordinator?.succesLogin.subscribe { [weak self] _ in
            self?.showTabbar(window)
            self?.loginCoordinator = nil
        }.disposed(by: disposeBag)
        
        loginCoordinator?.start(with: window)
    }
    
    private func showTabbar(_ window: UIWindow?) {
        mainTabBarCoordinator = MainTabBarCoordinator()
        mainTabBarCoordinator?.start(with: window)
    }
    
}
