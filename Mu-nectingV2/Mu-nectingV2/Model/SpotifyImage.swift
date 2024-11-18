//
//  AlbumImage.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 8/12/24.
//

import Foundation

struct SpotifyImage: Codable {
    let height : Int?
    let width : Int?
    let url : String
    
    enum CodingKeys: String, CodingKey {
        case height, width, url
    }
}
