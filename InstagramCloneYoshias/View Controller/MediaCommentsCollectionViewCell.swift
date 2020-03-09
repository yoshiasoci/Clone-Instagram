//
//  MediaCommentsCollectionViewCell.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit


class MediaCommentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoProfileCommentsImage: UIImageView!
    @IBOutlet weak var usernameCommentsLabel: UILabel!
    @IBOutlet weak var textCommentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoProfileCommentsImageCircle()
        
    }
    
    func photoProfileCommentsImageCircle() {
        photoProfileCommentsImage.layer.borderWidth = 0
        photoProfileCommentsImage.layer.masksToBounds = false
        photoProfileCommentsImage.layer.borderColor = UIColor.black.cgColor
        photoProfileCommentsImage.layer.cornerRadius = photoProfileCommentsImage.frame.height/2
        photoProfileCommentsImage.clipsToBounds = true
    }
    
    func populateCell(usernameComments: String, textComments: String) {
        //setPhotoProfileCommentsImage(from: photoProfileComments)
        usernameCommentsLabel.text = usernameComments
        textCommentsLabel.text = textComments
    }
    
//    func setPhotoProfileCommentsImage(from url: String?) {
//        guard let imageURL = URL(string: url ?? "me") else { return }
//
//            // just not to cause a deadlock in UI!
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.photoProfileCommentsImage.image = image
//            }
//        }
//    }
    
}
