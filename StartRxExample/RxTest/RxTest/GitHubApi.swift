//
//  GitHubApi.swift
//  RxTest
//
//  Created by Guilherme Martins on 2021/03/14.
//

import Foundation
import Moya

enum GitHub {
    case Users(since: Int)
}

extension GitHub: TargetType{
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL { return URL(string: "https//api.github.com")! }

    var path: String {
        switch self {
        case .Users:
            return "/users"
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    
}
