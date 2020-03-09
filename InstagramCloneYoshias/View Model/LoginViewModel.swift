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
    
    private func loginByFacebook() {
        let loginManager = LoginManager()
        loginManager.logOut()
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
    
//    private func getFBUserData() {
//            //which if my function to get facebook user details
//            //var idIgString: String = ""
//            //var accessToken = AccessToken.current
//        //self.instagramId.accept("17841401268594829")
//
//        if((AccessToken.current) != nil){
//
//            GraphRequest(graphPath: "me/accounts", parameters: ["fields": "instagram_business_account,id"]).start(completionHandler: { (connection, result, error) -> Void in
//                if (error == nil){
//
//                    let dict = result as! [String : AnyObject]
//                    print(result!)
//                    print(dict)
//                    let picutreDic = dict as NSDictionary
//                    let data = picutreDic.object(forKey: "data") as! NSArray
//                    let id = data.object(at: 1) as! NSDictionary
//                    let id_ig = id.object(forKey: "instagram_business_account") as! NSDictionary
//                    let idIgString = id_ig.object(forKey: "id") as! String
////                    self.instagramIdData.accept(idIgString)
////                     print(idIgString)
//
//                }
//
//                print(error?.localizedDescription as Any)
//            })
//
////                GraphRequest(graphPath: "\(String(describing: idIgString))", parameters: ["fields": "username"]).start(completionHandler: { (connection, result, error) -> Void in
////                    if (error == nil){
////
////                        let dict = result as! [String : AnyObject]
////                        print(result!)
////                        print(dict)
////                        let username = dict as NSDictionary
////                        let u = username.object(forKey: "username") as! String
////                        //idIgString = id_ig.object(forKey: "id") as! String?
////                        //self.emailLabel.text = u
////                        print(u)
////
////                    }
////
////                    print(error?.localizedDescription as Any)
////                })
//
//            }
//        }
    
    
    
}
