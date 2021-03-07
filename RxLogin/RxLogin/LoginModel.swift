//
//  LoginModel.swift
//  RxLogin
//
//  Created by Guilherme Martins on 2021/01/25.
//

import Foundation
import RxSwift
import RxCocoa

class LoginModel {
    
    let userNameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        Observable.combineLatest(userNameTextPublishSubject.asObservable(),
                                 passwordTextPublishSubject.asObserver())
            .map{ userName, password in
                    return userName.count > 3 && password.count > 3
                }
            .startWith(false)
    }
}
