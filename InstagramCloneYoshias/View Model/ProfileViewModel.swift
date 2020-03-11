//
//  ProfileViewModel.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/5/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Moya
//import SVProgressHUD

protocol ProfilePopulateable {
    func populateProfileViewEmpty()
    func populateProfileView(photoProfile: String?, nameProfile: String?, biographyProfile: String?, postProfileCount: Int?, followersProfileCount: Int?, followingProfileCount: Int?, websiteProfile: String?)
}

protocol ProfileViewModelable {
    
    //MARK: input
    var cellTapped: PublishSubject<Void> { get }
    var mediaId: BehaviorRelay<String?> { get }
    var logoutTapped: PublishSubject<Void> { get }
    
    
    //MARK: output
    var photoProfileImage: BehaviorRelay<UIImage?> { get }
    var nameProfileLabel: BehaviorRelay<String?> { get }
    var biographyProfileLabel: BehaviorRelay<String?> { get }
    var postProfileCountLabel: BehaviorRelay<String?> { get }
    var followersProfileCountLabel: BehaviorRelay<String?> { get }
    var followingProfileCountLabel: BehaviorRelay<String?> { get }
    var websiteProfileLabel: BehaviorRelay<String?> { get }
    
    //var mediaProfileCollectionView: BehaviorRelay<UICollectionView?> { get }
    var mediaProfileCollectionView: BehaviorRelay<[ProfileMediaData?]> { get }
    var detailMediaSubscription: ((_ mediaId: String, _ accessToken: String, _ photoProfileImageUrl: String) -> Void)? { get set }
    var logoutSubscription: ((_ successLogout: Bool) -> Void)? { get set }
}

class ProfileViewModel: ProfileViewModelable, ProfilePopulateable {
    
    private let apiServiceProvider = MoyaProvider<GraphApiInstagramService>()
    //private let mediaServiceProvider = MoyaProvider<MediaService>()
    private let disposeBag = DisposeBag()
    
    var detailMediaSubscription: ((_ mediaId: String, _ accessToken: String, _ photoProfileImageUrl: String) -> Void)?
    var cellTapped = PublishSubject<Void>()
    var logoutTapped = PublishSubject<Void>()
    var logoutSubscription: ((_ successLogout: Bool) -> Void)?
    
    let photoProfileImage = BehaviorRelay<UIImage?>(value: UIImage(named: ""))
    let nameProfileLabel = BehaviorRelay<String?>(value: "")
    let biographyProfileLabel = BehaviorRelay<String?>(value: "")
    let postProfileCountLabel = BehaviorRelay<String?>(value: "")
    let followersProfileCountLabel = BehaviorRelay<String?>(value: "")
    let followingProfileCountLabel = BehaviorRelay<String?>(value: "")
    let websiteProfileLabel = BehaviorRelay<String?>(value: "")
    
    var mediaProfileCollectionView = BehaviorRelay<[ProfileMediaData?]>(value: [])
    
    let accessToken: String
    let pathIdInstagram: String
    let mediaId = BehaviorRelay<String?>(value: "")
    let photoProfileImageUrl = BehaviorRelay<String?>(value: "")
    //let logout = BehaviorRelay<Bool?>(value: false)
    
    init(pathIdInstagram: String, accessToken: String) {
        self.pathIdInstagram = pathIdInstagram
        self.accessToken = accessToken
        //SVProgressHUD.show()
        getProfile()
        //getMediaProfile()
        makeSubscription()
        //SVProgressHUD.dismiss()
    }
    
    func makeSubscription() {
        logoutTapped.subscribe(onNext: { [weak self] _ in
            guard let self =  self else { return }
            self.logoutSubscription?(true)
            })
        .disposed(by: disposeBag)
        
        cellTapped.subscribe(onNext: { [weak self] _ in
            guard let self =  self else { return }
            self.detailMediaSubscription?(self.mediaId.value!, self.accessToken, self.photoProfileImageUrl.value!)
            })
        .disposed(by: disposeBag)
    }
    
    func getProfile() {
        //get Data
        apiServiceProvider.request(.getProfile(instagramId: self.pathIdInstagram, accessToken: self.accessToken)) { (result) in
            switch result {
                case .failure(let error):
                    print(error)
                    //onComplete(.failure(.unknown))
                    self.populateProfileViewEmpty()
                case .success(let response):
                    let profileData = try? JSONDecoder().decode(ProfileData.self, from: response.data)
                    self.populateProfileView(
                        photoProfile: profileData?.profile_picture_url,
                        nameProfile: profileData?.name,
                        biographyProfile: profileData?.biography,
                        postProfileCount: profileData?.media_count,
                        followersProfileCount: profileData?.followers_count,
                        followingProfileCount: profileData?.follows_count,
                        websiteProfile: profileData?.website)
                    self.mediaProfileCollectionView.accept((profileData?.media.data)!)
                    
                    //disiapin untuk detail
                    self.photoProfileImageUrl.accept(profileData?.profile_picture_url)
                    //onComplete(.success(weatherData))
            }
        }
        
        
        //get data
//        GraphRequest(graphPath: "17841401268594829", parameters: ["fields": "followers_count,media_count,follows_count,biography,name,username,website,profile_picture_url"]).start(completionHandler: { (connection, result, error) -> Void in
//            if (error == nil){
//                let dict = result as! [String : AnyObject]
//                print(result!)
//                print(dict)
//                let data = dict as NSDictionary
//                //self.nameProfileLabel.accept()
//                self.populateProfileView(
//                    photoProfile: data.object(forKey: "profile_picture_url") as? String,
//                    nameProfile: data.object(forKey: "name") as? String,
//                    biographyProfile: data.object(forKey: "biography") as? String,
//                    postProfileCount: String(describing: data.object(forKey: "media_count") as! Int),
//                    followersProfileCount: String(describing: data.object(forKey: "followers_count") as! Int),
//                    followingProfileCount: String(describing: data.object(forKey: "follows_count") as! Int),
//                    websiteProfile: data.object(forKey: "website") as? String)
//
//            }
//
//            print(error?.localizedDescription as Any)
//        })
    }
    
    //MARK: - Protocol Conformance
    
    func populateProfileViewEmpty() {
        populateProfileView(photoProfile: "", nameProfile: "", biographyProfile: "", postProfileCount: 0, followersProfileCount: 0, followingProfileCount: 0, websiteProfile: "")
    }
    
    func populateProfileView(photoProfile: String?, nameProfile: String?, biographyProfile: String?, postProfileCount: Int?, followersProfileCount: Int?, followingProfileCount: Int?, websiteProfile: String?) {
        
        //setPhotoProfileImage(from: photoProfile)
        
        setMedia(from: photoProfile, to: self.photoProfileImage)
        nameProfileLabel.accept(nameProfile)
        biographyProfileLabel.accept(biographyProfile)
        postProfileCountLabel.accept(postProfileCount == nil ? nil : "\(Int(postProfileCount!))")
        followersProfileCountLabel.accept(followersProfileCount == nil ? nil : "\(Int(followersProfileCount!))")
        followingProfileCountLabel.accept(followingProfileCount == nil ? nil : "\(Int(followingProfileCount!))")
        websiteProfileLabel.accept(websiteProfile)
        
    }
    
    //MARK: - Private Method
    
    private func setMedia(from url: String?, to imageDatas: BehaviorRelay<UIImage?>) {
        guard let imageURL = URL(string: url ?? "me") else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageDatas.accept(image)
            }
        }
    }
    
}
