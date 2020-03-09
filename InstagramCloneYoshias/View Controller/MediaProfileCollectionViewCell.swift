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
    
    func setMediaImage(from url: String?) {
        guard let imageURL = URL(string: url ?? "me") else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.feedPostProfileImage.image = image
            }
        }
    }
}
