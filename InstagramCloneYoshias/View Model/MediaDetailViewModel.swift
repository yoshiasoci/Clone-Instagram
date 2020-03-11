//
//  MediaDetailViewModel.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/6/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol MediaDetailPopulateable {
    func populateMediaDetailViewEmpty()
    func populateMediaDetailView(photoProfileMedia: String?, usernameMedia: String?, photoMedia: String?, likeCountMedia: Int?, commentCountMedia: Int?, captionMedia: String?)
}

protocol MediaDetailViewModelable {
    //MARK: output
    var photoProfileMediaImage: BehaviorRelay<UIImage?> { get }
    var photoMediaImage: BehaviorRelay<UIImage?> { get }
    var usernameMediaLabel: BehaviorRelay<String?> { get }
    var likeCountMediaLabel: BehaviorRelay<String?> { get }
    var commentCountMediaLabel: BehaviorRelay<String?> { get }
    var captionMediaLabel: BehaviorRelay<String?> { get }
    
    var commentsMediaCollectionView: BehaviorRelay<[MediaComments?]> { get }
}

class MediaDetailViewModel: MediaDetailViewModelable, MediaDetailPopulateable {
    
    private let apiServiceProvider = MoyaProvider<GraphApiInstagramService>()
    private let disposeBag = DisposeBag()
    
    let photoProfileMediaImage = BehaviorRelay<UIImage?>(value: UIImage(named: ""))
    let photoMediaImage = BehaviorRelay<UIImage?>(value: UIImage(named: ""))
    let usernameMediaLabel = BehaviorRelay<String?>(value: "")
    let likeCountMediaLabel = BehaviorRelay<String?>(value: "")
    let commentCountMediaLabel = BehaviorRelay<String?>(value: "")
    let captionMediaLabel = BehaviorRelay<String?>(value: "")
    
    var commentsMediaCollectionView = BehaviorRelay<[MediaComments?]>(value: [])
    
    let mediaId: String
    let accessToken: String
    let photoProfileImageUrl: String
    
    init(mediaId: String, accessToken: String, photoProfileImageUrl: String) {
        self.mediaId = mediaId
        self.accessToken = accessToken
        self.photoProfileImageUrl = photoProfileImageUrl
        getDetailMedia()
    }
    
    func getDetailMedia() {
        apiServiceProvider.request(.getDetailMediaProfile(mediaId: self.mediaId, accessToken: self.accessToken)) { (result) in
            switch result {
                case .failure(let error):
                    print(error)
                    //onComplete(.failure(.unknown))
                    self.populateMediaDetailViewEmpty()
                case .success(let response):
                    let mediaDetailData = try? JSONDecoder().decode(MediaData.self, from: response.data)
                    
                    self.populateMediaDetailView(
                        photoProfileMedia: self.photoProfileImageUrl,
                        usernameMedia: mediaDetailData?.username,
                        photoMedia: mediaDetailData?.media_url,
                        likeCountMedia: mediaDetailData?.like_count,
                        commentCountMedia: mediaDetailData?.comments_count,
                        captionMedia: mediaDetailData?.caption == nil ? "" : mediaDetailData?.caption)
                    
                    
                    
                    if mediaDetailData?.comments.data != nil {
                        self.commentsMediaCollectionView.accept(mediaDetailData!.comments.data)
                    }
                    //onComplete(.success(weatherData))
            }
        }
    }
    
    
    //MARK: - Protocol Conformance
    func populateMediaDetailViewEmpty() {
        populateMediaDetailView(photoProfileMedia: "", usernameMedia: "", photoMedia: "", likeCountMedia: 0, commentCountMedia: 0, captionMedia: "")
    }
    
    func populateMediaDetailView(photoProfileMedia: String?, usernameMedia: String?, photoMedia: String?, likeCountMedia: Int?, commentCountMedia: Int?, captionMedia: String?) {
        
//        setPhotoProfileMediaImage(from: photoProfileMedia)
//        setPhotoMediaImage(from: photoMedia)
        
        setMedia(from: photoMedia, to: self.photoMediaImage)
        setMedia(from: photoProfileMedia, to: self.photoProfileMediaImage)
        usernameMediaLabel.accept(usernameMedia)
        commentCountMediaLabel.accept(commentCountMedia == nil ? "0" : "💬 \(Int(commentCountMedia!))")
        likeCountMediaLabel.accept(likeCountMedia == nil ? "0" : "♥️ \(Int(likeCountMedia!))")
        captionMediaLabel.accept(captionMedia == nil ? "" : captionMedia)
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
    
   
//
//    private func setPhotoProfileMediaImage(from url: String?) {
//        guard let imageURL = URL(string: url ?? "me") else { return }
//
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.photoProfileMediaImage.accept(image)
//            }
//        }
//    }
//
//    private func setPhotoMediaImage(from url: String?) {
//        guard let imageURL = URL(string: url ?? "me") else { return }
//
//            // just not to cause a deadlock in UI!
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.photoMediaImage.accept(image)
//            }
//        }
//    }
    
}
