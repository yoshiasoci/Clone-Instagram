//
//  ProfileData.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct ProfileData: Decodable {
    var id: String
    var username: String
    var name: String
    var biography: String
    var website: String
    var profile_picture_url: String
    var media_count: Int
    var follows_count: Int
    var followers_count: Int
    var media: ProfileMedia
}

struct ProfileMedia: Decodable {
    var data: [ProfileMediaData]
}

struct ProfileMediaData: Decodable {
    var id: String
    var media_url: String
}

enum ProfileError: Error {
    case parameterNotValid, unknown
}
