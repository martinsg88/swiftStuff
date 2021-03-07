//
//  ViewController.swift
//  RxLogin
//
//  Created by Guilherme Martins on 2021/01/25.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    let loginModel = LoginModel()
    let disposeBag = DisposeBag()
    
    @IBAction func tappedLoginBtn(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.becomeFirstResponder()
        
        userNameTextField.rx.text.map { $0 ?? "" }.bind(to: loginModel.userNameTextPublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginModel.passwordTextPublishSubject).disposed(by: disposeBag)
        
        loginModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginModel.isValid().map{ $0 ? 1 : 0.1 }.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
        
    }


}

