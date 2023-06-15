//
//  MusicModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import Foundation

// MARK: - Welcome
struct Results: Codable {
    let resultCount: Int
    let results: [Track]
}

// MARK: - Result
struct Track: Codable {
    let trackID: Int?
    let artistName: String?
    let trackName: String?
    let artistViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let releaseDate: String?
    let trackTimeMillis: Int?
    let primaryGenreName: String?
    let artwork100: Data?

    enum CodingKeys: String, CodingKey {
        case trackID = "trackId"
        case artistName, trackName
        case artistViewURL = "artistViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl60, artworkUrl100, releaseDate, trackTimeMillis, primaryGenreName
        case artwork100
    }
}
