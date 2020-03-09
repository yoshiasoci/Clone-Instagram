//
//  ViewController.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    // Add this to the header of your file, e.g. in ViewController.m
    // after #import "ViewController.h"
    
    @IBAction func fbLogoutButton(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()

        let alertController = UIAlertController(title: "Logout", message: "Logout", preferredStyle: .alert)
        
        let action3 = UIAlertAction(title: "Destructive", style: .destructive) { (action:UIAlertAction) in
            print("You've pressed the destructive");
        }
        alertController.addAction(action3)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func fbLoginButton(_ sender: Any) {
        fbLogin()
    }
    
    func fbLogin() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(
        permissions: [.publicProfile, .email, .userFriends, .pagesShowList, "instagram_basic"], viewController: self ) { loginResult in
                switch loginResult{
                case .failed(let error):
                    //HUD.hide()
                    print(error)
                case .cancelled:
                    //HUD.hide()
                    print("Cancled Login")
                case .success( _,  _,  _):
                    print("Login")
                    self.getFBUserData()
                }
        }
    }
    
    func getFBUserData() {
        //which if my function to get facebook user details
        var idIgString: String = "17841401268594829"
        //var accessToken = AccessToken.current
        
        
        if((AccessToken.current) != nil){
            
            GraphRequest(graphPath: "me/accounts", parameters: ["fields": "instagram_business_account,id"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    let dict = result as! [String : AnyObject]
                    print(result!)
                    print(dict)
                    let picutreDic = dict as NSDictionary
                    let data = picutreDic.object(forKey: "data") as! NSArray
                    let id = data.object(at: 1) as! NSDictionary
                    let id_ig = id.object(forKey: "instagram_business_account") as! NSDictionary
                    idIgString = id_ig.object(forKey: "id") as! String
                    self.usernameLabel.text = idIgString
                   
                }
                
                print(error?.localizedDescription as Any)
            })
            
            GraphRequest(graphPath: "\(String(describing: idIgString))", parameters: ["fields": "username"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    let dict = result as! [String : AnyObject]
                    print(result!)
                    print(dict)
                    let username = dict as NSDictionary
                    let u = username.object(forKey: "username") as! String
                    //idIgString = id_ig.object(forKey: "id") as! String?
                    self.emailLabel.text = u
                   
                }
                
                print(error?.localizedDescription as Any)
            })
            
//            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
//                if (error == nil){
//
//                    let dict = result as! [String : AnyObject]
//                    print(result!)
//                    print(dict)
//                    let picutreDic = dict as NSDictionary
//                    let tmpURL1 = picutreDic.object(forKey: "picture") as! NSDictionary
//                    let tmpURL2 = tmpURL1.object(forKey: "data") as! NSDictionary
//                    let _ = tmpURL2.object(forKey: "url") as! String
//
//                    let nameOfUser = picutreDic.object(forKey: "name") as! String
//                    self.usernameLabel.text = nameOfUser
//
//                    var tmpEmailAdd = ""
//                    if let emailAddress = picutreDic.object(forKey: "email") {
//                        tmpEmailAdd = emailAddress as! String
//                        self.emailLabel.text = tmpEmailAdd
//                    }
//                    else {
//                        var usrName = nameOfUser
//                        usrName = usrName.replacingOccurrences(of: " ", with: "")
//                        tmpEmailAdd = usrName+"@facebook.com"
//                    }
//
//                }
//
//                print(error?.localizedDescription as Any)
//            })
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

