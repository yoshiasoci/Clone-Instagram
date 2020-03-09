//
//  MediaDetailViewController.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MediaDetailViewController: UIViewController {

    @IBOutlet weak var photoProfileMediaImage: UIImageView!
    @IBOutlet weak var usernameMediaLabel: UILabel!
    @IBOutlet weak var photoMediaImage: UIImageView!
    @IBOutlet weak var likeCountMediaLabel: UILabel!
    @IBOutlet weak var commentCountMediaLabel: UILabel!
    @IBOutlet weak var captionMediaLabel: UILabel!
    @IBOutlet weak var commentsMediaCollectionView: UICollectionView!
    
    var viewModelMediaDetail: MediaDetailViewModelable
    let disposeBag = DisposeBag()
    
    init(viewModel: MediaDetailViewModelable) {
        self.viewModelMediaDetail = viewModel
        super.init(nibName: "MediaDetail", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentsMediaCollectionView.register(UINib(nibName: "MediaCommentsCell", bundle: nil), forCellWithReuseIdentifier: "MediaCommentsCollectionViewCell")
        bindData()
        self.imageProfileCircle()
        //.backgroundColor = UIColor(patternImage: yourImage)
        
        //title navigation
        navigationItem.title = "Detail Media"
    }
    
    func imageProfileCircle() {
        photoProfileMediaImage.layer.borderWidth = 0
        photoProfileMediaImage.layer.masksToBounds = false
        photoProfileMediaImage.layer.borderColor = UIColor.black.cgColor
        photoProfileMediaImage.layer.cornerRadius = photoProfileMediaImage.frame.height/2
        photoProfileMediaImage.clipsToBounds = true
    }
    
    func bindData() {
        //data binding
        viewModelMediaDetail.photoMediaImage
            .asObservable()
            .map{ $0 }
            .bind(to: self.photoMediaImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModelMediaDetail.photoProfileMediaImage
            .asObservable()
            .map{ $0 }
            .bind(to: self.photoProfileMediaImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModelMediaDetail.usernameMediaLabel
            .asObservable()
            .map{ $0 }
            .bind(to: usernameMediaLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelMediaDetail.likeCountMediaLabel
            .asObservable()
            .map{ $0 }
            .bind(to: likeCountMediaLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelMediaDetail.commentCountMediaLabel
            .asObservable()
            .map{ $0 }
            .bind(to: commentCountMediaLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelMediaDetail.captionMediaLabel
            .asObservable()
            .map{ $0 }
            .bind(to: captionMediaLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelMediaDetail.commentsMediaCollectionView
            .asObservable()
            .bind(to: commentsMediaCollectionView.rx.items(cellIdentifier: "MediaCommentsCollectionViewCell", cellType: MediaCommentsCollectionViewCell.self)) { (row,data,cell) in
                cell.populateCell(usernameComments: data!.username, textComments: data!.text)
            }
            .disposed(by: disposeBag)
    
    }

}
