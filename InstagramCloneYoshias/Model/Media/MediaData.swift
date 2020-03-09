//
//  PostData.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
//Detail Media Data
struct MediaData: Decodable {
    var id: String
    var username: String
    var caption: String
    var comments_count: Int
    var like_count: Int
    var media_url: String
    var comments: MediaCommentsData
}

//Media Data in Profile
struct MediaDataUrl: Decodable {
    var data: [MediaDataUrlDetail]
}

struct MediaDataUrlDetail: Decodable {
    var id: String
    var media_url: String
}

enum MediaError: Error {
    case parameterNotValid, unknown
}

