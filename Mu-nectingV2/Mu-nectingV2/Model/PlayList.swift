//
//  PlayList.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/22/24.
//

import Foundation

struct PlayList : Codable {
    let playListId : Int?
    let title : String?
    let musicList : [Track?]
    
    enum CodingKeys: String, CodingKey {
        case playListId, title, musicList
    }
}
