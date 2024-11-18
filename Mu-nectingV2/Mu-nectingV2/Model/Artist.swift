//
//  Artist.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 8/12/24.
//

import Foundation

struct Artist: Codable {
    let artistName : String?
    let artistId : String?
    let artistUri : String?
    let images : [SpotifyImage]?
    
    enum CodingKeys: String, CodingKey {
        case artistName, artistId, artistUri, images
    }
}
