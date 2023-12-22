
//  RegisterManager.swift
//  SayurKu
//
//  Created by Pungki Busneri on 18/12/23.


import Foundation
import Moya
import SwiftyJSON

class RegisterManager {
    static let shared = RegisterManager()
    private let networkService = NetworkService()

    private init() {}

    func registerUser(name: String, email: String, password: String, completion: @escaping ((_ data: JSON?, _ error: String?, _ statusCode: Int?) -> Void)) {
        let endpoint = Endpoint.register(name: name, email: email, password: password)
        NetworkService.request(endpoint: endpoint, completion: completion)
    }
}
