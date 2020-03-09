//
//  MediaDetailCoordinator.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class MediaDetailCoordinator: NavigationCoordinator {
    var viewController: UIViewController = .init()
    
    var parentCoordinator: ProfileCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start(mediaId: String, accessToken: String, photoProfileImageUrl: String) {
        let mediaDetailViewController = MediaDetailViewController(viewModel: MediaDetailViewModel(mediaId: mediaId, accessToken: accessToken, photoProfileImageUrl: photoProfileImageUrl))
        viewController = mediaDetailViewController
        navigationController.pushViewController(mediaDetailViewController, animated: false)
    }
    
}
