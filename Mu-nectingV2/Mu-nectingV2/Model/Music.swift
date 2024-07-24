//
//  Music.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 3/28/24.
//

import Foundation

struct Music : Codable {
    let musicId : Int
    let title : String?
    let albumImage : String?
    let musicTime : String?
    let singer : String?
    
    enum CodingKeys: String, CodingKey {
        case musicId, title, albumImage, musicTime, singer
    }
}
