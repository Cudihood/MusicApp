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
//    let wrapperType: String?
//    let kind: String?
//    let artistID, collectionID,
    let trackID: Int?
    let artistName: String?
    let trackName: String?
    let artistViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl60, artworkUrl100: String?
    let releaseDate: String?
//    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let primaryGenreName: String?
//    let isStreamable: Bool?
    let artwork100: Data?

    enum CodingKeys: String, CodingKey {
//        case wrapperType, kind
//        case artistID = "artistId"
//        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, trackName
        case artistViewURL = "artistViewUrl"
//        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl60, artworkUrl100, releaseDate, trackTimeMillis, primaryGenreName
        case artwork100
    }
}
//
////enum Kind: String, Codable {
////    case song = "song"
////}
////
////enum WrapperType: String, Codable {
////    case track = "track"
////}

//// MARK: - Welcome
//struct Welcome: Codable {
//    let resultCount: Int?
//    let results: [Result]?
//}
//
//// MARK: - Result
//struct Result: Codable {
//    let artistName, collectionName: String?
//    let trackName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case artistName, collectionName, trackName
//    }
//}

//enum Explicitness: String, Codable {
//    case explicit = "explicit"
//    case notExplicit = "notExplicit"
//}
//
//enum Country: String, Codable {
//    case usa = "USA"
//}
//
//enum Currency: String, Codable {
//    case usd = "USD"
//}
//
//enum Kind: String, Codable {
//    case song = "song"
//}
//
//enum TrackName: String, Codable {
//    case purpleЛето = "Лето !!!!"
//    case trackNameЛЕТО = "ЛЕТО"
//    case trackNameЛето = "лето"
//    case лето = "Лето"
//}
//
//enum WrapperType: String, Codable {
//    case track = "track"
//}
