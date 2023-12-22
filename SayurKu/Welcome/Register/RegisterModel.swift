//
//  RegisterModel.swift
//  SayurKu
//
//  Created by Pungki Busneri on 18/12/23.
//

import Foundation
import SwiftyJSON

struct RegisterModel {
    let code: String
    let message: String
    
    init (json: JSON) {
        code = json["code"].stringValue
        message = json["message"].stringValue
    }
}
