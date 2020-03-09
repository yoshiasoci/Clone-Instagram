//
//  MainTabBarCoordinator.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MainTabBarCoordinator: Coordinator {
    var viewController: UIViewController = .init()
    
    //private let loginCoordinator = LoginCoordinator()
    private let profileCoordinator = ProfileCoordinator()
    
    let logout: PublishSubject<Void> = .init()
    
    let disposeBag = DisposeBag()
    
    func start(accessToken: String?) {
        
        profileCoordinator.logout
            .bind(to: logout)
            .disposed(by: disposeBag)
        
        profileCoordinator.start(accessToken: accessToken)
        let viewControllers = [profileCoordinator.navigationController]
        
        let tabBarItems: [UITabBarItem] = [
            //UITabBarItem(title: "", image: UIImage(named: "home"), tag: 1),
            UITabBarItem(title: "", image: UIImage(named: "profile"), tag: 1)
        ]
        
        let viewModel = MainTabBarViewModel(
            viewControllers: viewControllers,
            tabBarItems: tabBarItems
        )
        
        self.viewController = MainTabBarController(viewModel: viewModel)
    }
    
    func start(with window: UIWindow?, accessToken: String?) {
        start(accessToken: accessToken)
        window?.rootViewController = viewController
    }
}
