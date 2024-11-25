//
//  LoginAPI.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 9/2/24.
//

import Foundation
import Moya

enum LoginAPI {
    // Member Controller
    case loginWithSocial(socialType : String, idToken : String)
}

extension LoginAPI : BaseAPI {
    public var task: Task {
        switch self {
        case .loginWithSocial(let socialType, let idToken) :
            var parameters: [String: Any] = [:]
            
            parameters["socialType"] = socialType
            parameters["idToken"] = idToken
            
            print(socialType)
            print(idToken)
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .loginWithSocial :
            return .post
        }
    }
    
    public var path : String {
        switch self {
        case .loginWithSocial :
            return "/api/auth/login"
        }
    }

}
