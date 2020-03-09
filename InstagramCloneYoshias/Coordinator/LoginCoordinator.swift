//
//  LoginByFacebookCoordinator.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class LoginCoordinator: Coordinator {
    lazy var viewController: UIViewController = .init()
    private var disposeBag = DisposeBag()
    
    var succesLogin: PublishSubject<Void> = .init()
    //var sucesLogin = PublishSubject<String?>()
    
    func start() {
        let viewModel = LoginViewModel()
        viewController = LoginViewController(viewModel: viewModel)
        viewModel.succesLogin
            .bind(to: succesLogin)
            .disposed(by: disposeBag)
    }
    
    func start(with window: UIWindow?) {
        start()
        window?.rootViewController = viewController
    }
}
