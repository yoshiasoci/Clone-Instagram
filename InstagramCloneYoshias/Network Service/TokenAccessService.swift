//
//  TokenAccessService.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/5/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import FBSDKShareKit

class TokenAccessService {
    
    func getInstagramId() {
        GraphRequest(graphPath: "me/accounts", parameters: ["fields": "instagram_business_account,id"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                
                let dict = result as! [String : AnyObject]
                print(result!)
                print(dict)
                let picutreDic = dict as NSDictionary
                let data = picutreDic.object(forKey: "data") as! NSArray
                let id = data.object(at: 1) as! NSDictionary
                let id_ig = id.object(forKey: "instagram_business_account") as! NSDictionary
                //self.instagramId = id_ig.object(forKey: "id") as! String
                
            }
            
            print(error?.localizedDescription as Any)
        })
    }

}
