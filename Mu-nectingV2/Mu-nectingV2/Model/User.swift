//
//  User.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 3/27/24.
//

import Foundation

struct User : Codable {
    let userID : Int
    let nickName : String
    
    enum CodingKeys: String, CodingKey {
        case userID, nickName
    }
}
