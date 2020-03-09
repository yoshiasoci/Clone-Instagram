//
//  MediaCommentsData.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct MediaCommentsData: Decodable {
    var data: [MediaComments]
}

struct MediaComments: Decodable {
    var id: String
    var username: String
    var text: String
}
