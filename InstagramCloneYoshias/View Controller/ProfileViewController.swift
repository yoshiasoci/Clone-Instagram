//
//  ProfileViewController.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/3/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {

    @IBOutlet weak var photoProfileImage: UIImageView!
    @IBOutlet weak var nameProfileLabel: UILabel!
    @IBOutlet weak var biographyProfileLabel: UILabel!
    @IBOutlet weak var postProfileCountLabel: UILabel!
    @IBOutlet weak var followersProfileCountLabel: UILabel!
    @IBOutlet weak var followingProfileCountLabel: UILabel!
    @IBOutlet weak var mediaProfileCollectionView: UICollectionView!
    @IBOutlet weak var websiteProfileLabel: UILabel!
    
    var viewModelProfile: ProfileViewModelable
    let disposeBag = DisposeBag()
    
    init(viewModel: ProfileViewModelable) {
        self.viewModelProfile = viewModel
        super.init(nibName: "Profile", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediaProfileCollectionView.register(UINib(nibName: "MediaProfileCell", bundle: nil), forCellWithReuseIdentifier: "PostProfileCollectionViewCell")
        
        self.addElement()
        self.bindData()
        self.imageProfileCircle()
        
        //title navigation
        navigationItem.title = "Profile"
    }
    
    func imageProfileCircle() {
        photoProfileImage.layer.borderWidth = 0.1
        photoProfileImage.layer.masksToBounds = false
        photoProfileImage.layer.borderColor = UIColor.black.cgColor
        photoProfileImage.layer.cornerRadius = photoProfileImage.frame.height/2
        photoProfileImage.clipsToBounds = true
    }
    
    func addElement() {
        //add button in right navigation bar
        let logOutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem  = logOutButton
    }
    
    //implementasi button
    @objc func logOut(){
//        let loginManager = LoginManager()
//        print(AccessToken.current?.tokenString as Any)
//        loginManager.logOut()
//        print(AccessToken.current?.tokenString as Any)
        print("logout")
        //present(searchController, animated: true, completion: nil)
    }
    
    func bindData() {
        //binding label
        viewModelProfile.photoProfileImage
            .asObservable()
            .map{ $0 }
            .bind(to: self.photoProfileImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModelProfile.nameProfileLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.nameProfileLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelProfile.biographyProfileLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.biographyProfileLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelProfile.postProfileCountLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.postProfileCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelProfile.followersProfileCountLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.followersProfileCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelProfile.followingProfileCountLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.followingProfileCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelProfile.websiteProfileLabel
            .asObservable()
            .map{ $0 }
            .bind(to: self.websiteProfileLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModelProfile.mediaProfileCollectionView
            .asObservable()
            .bind(to: mediaProfileCollectionView.rx.items(cellIdentifier: "PostProfileCollectionViewCell", cellType: MediaProfileCollectionViewCell.self)) { (row,data,cell) in
                cell.setMediaImage(from: data?.media_url)
        }.disposed(by: disposeBag)
        
        //binding cell tapable
        self.mediaProfileCollectionView.rx.modelSelected(MediaDataUrlDetail.self)
            .subscribe(onNext: { (model) in
                print(model.id)
                self.viewModelProfile.mediaId.accept(model.id)
                self.viewModelProfile.cellTapped.onNext(())
        }).disposed(by: disposeBag)
        
    }
    

}
