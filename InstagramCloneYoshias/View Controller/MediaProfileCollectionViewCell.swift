//
//  PostProfileCollectionViewCell.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/3/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MediaProfileCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var feedPostProfileImage: UIImageView!
    
    func populateCell(mediaUrl: String?) {
        setMedia(from: mediaUrl, to: feedPostProfileImage)
    }
    
    //MARK: - Provate Method
    private func setMedia(from url: String?, to uiImageView: UIImageView?) {
        guard let imageURL = URL(string: url ?? "me") else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                uiImageView?.image = image
            }
        }
    }
}
