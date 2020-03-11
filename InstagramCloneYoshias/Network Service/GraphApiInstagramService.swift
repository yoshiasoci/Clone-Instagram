//
//  ServiceProfile.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Moya

enum GraphApiInstagramService {
    case getProfile(instagramId: String, accessToken: String)
    case getDetailMediaProfile(mediaId: String, accessToken: String)
    
    //bypass
    case getDummyData
}

extension GraphApiInstagramService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://graph.facebook.com")!
    }
    
    var path: String {
        switch self {
        case .getDummyData:
            return "/v6.0/17871747100103711"
        case .getProfile(let instagramId, _):
            return "/v6.0/\(instagramId)"
        case .getDetailMediaProfile(let mediaId, _):
            return "/v6.0/\(mediaId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfile(_, _), .getDetailMediaProfile(_, _), .getDummyData:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getDummyData:
            return "".data(using: .utf8)!
        case .getProfile(let instagramId, let accessToken):
            return "\(instagramId),\(accessToken)".data(using: .utf8)!
        case .getDetailMediaProfile(let mediaId, let accessToken):
            return "\(mediaId),\(accessToken)".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .getDummyData:
            return .requestParameters(parameters: ["fields" : "id,username,media_url", "access_token" : ""], encoding: URLEncoding.default)
        case .getProfile(_, let accessToken):
            return .requestParameters(parameters: ["fields" : "followers_count,media_count,follows_count,biography,name,username,website,profile_picture_url,media{id,media_url}", "access_token" : "\(accessToken)"], encoding: URLEncoding.default)
        case .getDetailMediaProfile(_, let accessToken):
            return .requestParameters(parameters: ["fields" : "id,username,caption,comments_count,like_count,media_url,comments{id,username,text}", "access_token" : "\(accessToken)"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    
}
