//
//  Endpoint.swift
//  SayurKu
//
//  Created by Pungki Busneri on 17/12/23.
//

import Foundation
import Moya

enum Endpoint {
    case register (name: String, email: String, password: String)
    case login (email: String, password: String)
}
extension Endpoint: TargetType {
    var baseURL: URL {
        return URL(string: APIConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .register:
            return APIConstant.register
        case .login:
            return APIConstant.login
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case .register(name: let name, email: let email, password: let password):
            let parameters: [String: Any] = ["name": name, "email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .login(email: let email, password: let password):
            let parameters: [String: Any] = ["email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
