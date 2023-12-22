//
//  NetworkSupport.swift
//  SayurKu
//
//  Created by Pungki Busneri on 18/12/23.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

final class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration  = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

struct VerbosePlugin: PluginType {
    let isVerbose: Bool
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
#if DEBUG
        
        if let request = request.urlRequest {
            print("🟠 Request URL   : \(request)")
        }
        if let body = request.httpBody,
           let parameters = String(data: body, encoding: .utf8) {
            print("🟠 Request Body  : (parameters: \(parameters))")
        }
#endif
        return request
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
#if DEBUG
        switch result {
        case .success(let body):
            if isVerbose {
                if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                    let sCode = body.statusCode
                    let dataJSON = JSON(json)
                    if sCode == 200{
                        print("⚪️ Status Code       :\(sCode)")
                        print("⚪️ Response          :↓\n\(dataJSON)\n\n")
                    }
                    else {
                        print("🔴 Status Code       :\(sCode)")
                        print("🔴 Response          :↓\n\(dataJSON)\n\n")
                    }
                } else {
                    let response = String(data: body.data, encoding: .utf8)!
                    print("🔴 Response             :↓\n\(response)\n\n")
                }
            }
        case .failure(let error):
            print("🔴 Error Code              :\(error.errorCode)")
            print("🔴 Localized Description   :\(error.localizedDescription)")
            print("🔴 error User Info         :\(error.errorUserInfo)\n\n")
        }
#endif
    }
}
