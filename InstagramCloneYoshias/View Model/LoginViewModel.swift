//
//  LoginByFacebookViewModel.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import FacebookLogin
import FBSDKLoginKit
import FacebookCore

protocol LoginInstagramViewModelable {
    //MARK: input
    var loginByFacebookButton: PublishSubject<Void> { get }
    
    //MARK: output
    var succesLogin: PublishSubject<Void> { get }
    
}

class LoginViewModel: LoginInstagramViewModelable {
    var succesLogin: PublishSubject<Void> = .init()
    
    let disposeBag = DisposeBag()
    var loginByFacebookButton = PublishSubject<Void>()
    
    init() {
        self.makeSubscription()
    }
    
    private func makeSubscription() {
        
        loginByFacebookButton.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            //action here
//            let log = LoginManager()
//            log.logOut()
            
            print(AccessToken.current?.tokenString as Any)
            self.loginByFacebook()
        }).disposed(by: disposeBag)
        
    }
    
    //MARK: - Private Method
    
    private func loginByFacebook() {
        let loginManager = LoginManager()
//        loginManager.logOut()
        loginManager.logIn(
        permissions: [.publicProfile, .email, .userFriends, .pagesShowList, "instagram_basic"], viewController: LoginViewController(viewModel: self) ) { loginResult in
                switch loginResult{
                case .failed(let error):
                    //HUD.hide()
                    print(error)
                case .cancelled:
                    //HUD.hide()
                    print("Cancled Login")
                case .success( _,  _,  _):
                    print("Login")
                    //self.getFBUserData()
                    self.succesLogin.onNext(())
                    //self.sucesLogin.onNext(true)
                }
        }
    }
}
