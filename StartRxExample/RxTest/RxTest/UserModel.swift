//
//  UserModel.swift
//  RxTest
//
//  Created by Guilherme Martins on 2021/03/14.
//

import Foundation
import RxSwift
import RxOptional
import Moya
import Moya_ModelMapper

struct UserModel {
    let provider: MoyaProvider<GitHub>
    
    func getUsers(since: Int)->Observable<[Users]> {
        return self.provider.rx.request(GitHub.Users(since: since)).map(to: [Users].self).asObservable()
    }
    
    
}
