//
//  ProfileCoordinator.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore
import RxSwift

class ProfileCoordinator: NSObject, ParentCoordinator, UINavigationControllerDelegate {
    var viewController: UIViewController = .init()
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var logout: PublishSubject<Void> = .init()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start(accessToken: String?) {
        navigationController.delegate = self
        //get pathIdInstagram
        GraphRequest(graphPath: "me/accounts", parameters: ["fields": "instagram_business_account,id"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                    
                let dict = result as! [String : AnyObject]
                print(result!)
                print(dict)
                let picutreDic = dict as NSDictionary
                let data = picutreDic.object(forKey: "data") as! NSArray
                let id = data.object(at: 1) as! NSDictionary
                let id_ig = id.object(forKey: "instagram_business_account") as! NSDictionary
                let idIgString = id_ig.object(forKey: "id") as! String
                //idInstagram.accept(idIgString)
                let viewModel = ProfileViewModel(pathIdInstagram: idIgString, accessToken: accessToken!)
                
                viewModel.detailMediaSubscription = { [weak self] mediaId, accessToken, photoProfileImageUrl in
                    self?.detailMediaSubscription(mediaId: mediaId, accessToken: accessToken, photoProfileImageUrl: photoProfileImageUrl)
                }
                
                viewModel.logoutSubscription = { [weak self] logout in
                    self?.logoutSubscription(logout: logout)
                }
                
                self.viewController = ProfileViewController(viewModel: viewModel)
                self.navigationController.pushViewController(self.viewController, animated: false)
            }
            
            print(error?.localizedDescription as Any)
        })
        
//        let viewModel = ProfileViewModel(pathIdInstagram: idInstagram.value!)
//        viewController = ProfileViewController(viewModel: viewModel)
//        navigationController.pushViewController(viewController, animated: false)
    }
    
    func logoutSubscription(logout: Bool) {
        if logout {
            print("tapped")
            let loginManager = LoginManager()
            loginManager.logOut()
            self.logout.onNext(())
        }
    }
    
    func detailMediaSubscription(mediaId: String, accessToken: String, photoProfileImageUrl: String) {
        let child = MediaDetailCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start(mediaId: mediaId, accessToken: accessToken, photoProfileImageUrl: photoProfileImageUrl)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if fromViewController is MediaDetailViewController {
            childCoordinators.enumerated().forEach {
                if $0.element.viewController === fromViewController {
                    childCoordinators.remove(at: $0.offset)
                }
            }
        }

    }
    
}
