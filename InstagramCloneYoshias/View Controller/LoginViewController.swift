//
//  LoginByFacebookViewController.swift
//  InstagramCloneYoshias
//
//  Created by admin on 3/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginByFacebookButton: UIButton!
    
    var viewModelLogin: LoginInstagramViewModelable
    let disposeBag = DisposeBag()
    
    init(viewModel: LoginInstagramViewModelable) {
        self.viewModelLogin = viewModel
        super.init(nibName: "Login", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindData()
    }
    
    func bindData() {
        self.loginByFacebookButton.rx.tap
            .bind(to: self.viewModelLogin.loginByFacebookButton)
            .disposed(by: disposeBag)
    }

}
