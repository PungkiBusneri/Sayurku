//
//  LoginManager.swift
//  SayurKu
//
//  Created by Pungki Busneri on 18/12/23.
//

import Foundation
import Moya
import SwiftyJSON

class LoginManager {
    static let shared = LoginManager()
    private let networkService = NetworkService()

    private init() {}

    func loginUser(email: String, password: String, completion: @escaping ((_ data: JSON?, _ error: String?, _ statusCode: Int?) -> Void)) {
        let endpoint = Endpoint.login(email: email, password: password)
        NetworkService.request(endpoint: endpoint, completion: completion)
    }
}
