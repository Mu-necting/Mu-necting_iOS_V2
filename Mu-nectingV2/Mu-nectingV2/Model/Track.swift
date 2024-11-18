//
//  Music.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 3/28/24.
//

import Foundation

struct Track : Codable {
    let trackId : String?
    let trackTitle : String?
    let trackPreview : String?
    let albumImages : [SpotifyImage]?
    let artists : [Artist]?
    let musicTime : String? // 필요 없을지도

    enum CodingKeys: String, CodingKey {
        case trackId, trackTitle, trackPreview, albumImages, artists, musicTime
    }
}
