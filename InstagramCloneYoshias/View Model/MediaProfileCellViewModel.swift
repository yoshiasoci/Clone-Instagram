//
//  MediaProfileCollectionViewCellViewModel.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/8/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol MediaProfileCellViewModelable {
    var detailMediaSubscription: ((_ mediaId: String, _ accessToken: String) -> Void)? { get set }
}

class MediaProfileCellViewModel: MediaProfileCellViewModelable {
    var detailMediaSubscription: ((_ mediaId: String, _ accessToken: String) -> Void)?
    
    
}
