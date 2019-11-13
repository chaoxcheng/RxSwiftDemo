//
//  SimpleValidationViewController.swift
//  RxSwiftDemo
//
//  Created by SimonCheng on 2019/10/16.
//  Copyright © 2019 Channing. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {
    
    let userNameLabel: UILabel = {
        let temp = UILabel()
        temp.text = "UserName"
        return temp
    }()
    
    lazy var userNameTextfiled: UITextField = {
        let temp = UITextField()
        temp.borderStyle = .roundedRect
        return temp
    }()
    
    let userNameTipLabel: UILabel = {
        let temp = UILabel()
        temp.text = "Username has to be at least \(minimalUsernameLength) characters"
        temp.textColor = .red
        return temp
    }()
    
    let passwordLabel: UILabel = {
        let temp = UILabel()
        temp.text = "PassWord"
        return temp
    }()
    
    lazy var passwordTextfiled: UITextField = {
        let temp = UITextField()
        temp.borderStyle = .roundedRect
        return temp
    }()
    
    let passwordTipLabel: UILabel = {
        let temp = UILabel()
        temp.text = "Password has to be at least \(minimalPasswordLength) characters"
        temp.textColor = .red
        return temp
    }()
    
    lazy var dosomethingButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("do something", for: .normal)
        temp.setTitleColor(.black, for: .normal)
        temp.setTitleColor(.white, for: .disabled)
        temp.backgroundColor = UIColor.orange
        return temp
    }()
    
    lazy var disposeBag: DisposeBag = {
        let temp = DisposeBag()
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupAndLayoutSubviews()
        setupValid()
    }
    
    func setupAndLayoutSubviews() {
        view.addSubview(userNameLabel)
        userNameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        view.addSubview(userNameTextfiled)
        userNameTextfiled.snp_makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp_bottom).offset(10)
            make.left.right.equalTo(userNameLabel)
        }
        
        view.addSubview(userNameTipLabel)
        userNameTipLabel.snp_makeConstraints { (make) in
            make.top.equalTo(userNameTextfiled.snp_bottom).offset(10)
            make.left.right.equalTo(userNameLabel)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp_makeConstraints { (make) in
            make.top.equalTo(userNameTipLabel.snp_bottom).offset(10)
            make.left.right.equalTo(userNameLabel)
        }
        
        view.addSubview(passwordTextfiled)
        passwordTextfiled.snp_makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp_bottom).offset(10)
            make.left.right.equalTo(userNameLabel)
        }
        
        view.addSubview(passwordTipLabel)
        passwordTipLabel.snp_makeConstraints { (make) in
            make.top.equalTo(passwordTextfiled.snp_bottom).offset(10)
            make.left.right.equalTo(userNameLabel)
        }
        
        view.addSubview(dosomethingButton)
        dosomethingButton.snp_makeConstraints { (make) in
            make.top.equalTo(passwordTipLabel.snp_bottom).offset(10)
            make.left.right.equalTo(userNameLabel)
            make.height.equalTo(50)
        }
    }
    
    func setupValid() {
         let usernameValid = userNameTextfiled.rx.text.orEmpty
                   .map { $0.count >= minimalUsernameLength }
                   .share(replay: 1)
               
        let passwordVaild = passwordTextfiled.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythinValid = Observable.combineLatest(usernameValid, passwordVaild)
            { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextfiled.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: userNameTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordVaild
            .bind(to: passwordTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythinValid
            .bind(to: dosomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        dosomethingButton.rx.tap
            .subscribe(onNext: {
                print("This is wonderful")
            })
            .disposed(by: disposeBag)
    }
}
