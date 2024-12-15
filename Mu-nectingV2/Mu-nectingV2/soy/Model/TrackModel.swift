//
//  TrackModel.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 12/16/24.
//

import Foundation

struct Tracks: Codable {
    let trackId: String
    let trackUri: String
    let trackTitle: String
    let trackPreview: String
    let artists: [Artist]
    let images: [Images]
}

struct Artists: Codable {
    let artistName: String
    let artistId: String
    let artistUri: String
    let images: [Images]?
}

struct Images: Codable {
    let height: Int
    let url: String
    let width: Int
}

struct APIResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let data: [Track]
}
