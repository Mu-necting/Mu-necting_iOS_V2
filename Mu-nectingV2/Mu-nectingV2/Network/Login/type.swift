//
//  type.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 11/18/24.
//

import Foundation

struct LoginResponse : Codable {
    let accessToken : String
    let refreshToken : String
    
    enum CodingKeys : String, CodingKey{
        case accessToken
        case refreshToken
    }
}
