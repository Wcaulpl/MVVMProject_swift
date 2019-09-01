//
//  XYLoginController.swift
//  XYSwiftMVVM
//
//  Created by Wcaulpl on 2019/6/17.
//  Copyright © 2019 Wcaulpl. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class XYLoginController: UIViewController {
    
    let bag = DisposeBag()
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userNameValidationLabel: UILabel!

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!

    @IBOutlet weak var confirmPsdField: UITextField!
    @IBOutlet weak var confirmPsdValidationLabel: UILabel!

    @IBOutlet weak var signUpBtn: UIButton!
    
    let minUserNameLength = 6
    let minPasswordLength = 6

    override func viewDidLoad() {
        super.viewDidLoad()

        userNameValidationLabel.text = "Username has to be at least \(minUserNameLength) characters"
        passwordValidationLabel.text = "Password has to be at least \(minPasswordLength) characters"
        confirmPsdValidationLabel.text = "两次输入不一致"
        
        // 用户名是否有效
        let userNameValid = userNameField.rx.text.orEmpty
            // 用户名 -> 用户名是否有效
            .map { $0.count >= self.minUserNameLength}
            .share(replay: 1)

        // 用户名是否有效 -> 用户名提示语是否隐藏
        userNameValid.bind(to: userNameValidationLabel.rx.isHidden).disposed(by: bag)

        
        // 密码是否有效
        let passwordValid = passwordField.rx.text.orEmpty
            // 密码 -> 密码是否有效
            .map { $0.count >= self.minPasswordLength }
            .share(replay: 1)

        // 密码是否有效 -> 密码提示语是否隐藏
        passwordValid.bind(to: passwordValidationLabel.rx.isHidden).disposed(by: bag)
        passwordValid.bind(to: confirmPsdField.rx.isEnabled).disposed(by: bag)

        
        // 确认密码是否有效
        let confirmValid = confirmPsdField.rx.text.orEmpty
            // 确认密码 -> 二次输入是否正确
            .map { $0 == self.passwordField.text}
            .share(replay: 1)
        // 确认密码是否有效 -> 确认密码提示语是否隐藏
        confirmValid.bind(to: confirmPsdValidationLabel.rx.isHidden).disposed(by: bag)
        
        // 所有输入是否有效
        let everythingValid = Observable.combineLatest(
            userNameValid,
            passwordValid,
            confirmValid
        ) { $0 && $1 && $2} // 取用户名和密码同时有效
            .share(replay: 1)
        
        // 所有输入是否有效 -> 绿色按钮是否可点击
        everythingValid
            .bind(to: signUpBtn.rx.isEnabled)
            .disposed(by: bag)
        
    }

}
