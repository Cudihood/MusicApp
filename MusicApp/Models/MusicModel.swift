//
//  MusicModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import Foundation
import CoreData

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

    enum CodingKeys: String, CodingKey {
        case trackID = "trackId"
        case artistName, trackName
        case artistViewURL = "artistViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl60, artworkUrl100, releaseDate, trackTimeMillis, primaryGenreName
    }
}

extension Track {
    init(musicTrack: MusicTrack) {
        trackID = Int(musicTrack.trackID)
        artistName = musicTrack.artistName
        trackName = musicTrack.trackName
        artistViewURL = musicTrack.artistViewURL
        trackViewURL = musicTrack.trackViewURL
        previewURL = musicTrack.previewURL
        artworkUrl60 = nil
        artworkUrl100 = musicTrack.artworkUrl100
        releaseDate = musicTrack.releaseDate
        trackTimeMillis = Int(musicTrack.trackTimeMillis)
        primaryGenreName = musicTrack.primaryGenreName
    }
    
    func createTrackDB(context: NSManagedObjectContext) {
        let musicTrack = MusicTrack(context: context)
        musicTrack.trackID = Int64(self.trackID ?? 0)
        musicTrack.artistName = self.artistName
        musicTrack.trackName = self.trackName
        musicTrack.artistViewURL = self.artistViewURL
        musicTrack.trackViewURL = self.trackViewURL
        musicTrack.previewURL = self.previewURL
        musicTrack.artworkUrl100 = self.artworkUrl100
        musicTrack.releaseDate = self.releaseDate
        musicTrack.trackTimeMillis = Int64(self.trackTimeMillis ?? 0)
        musicTrack.primaryGenreName = self.primaryGenreName
    }
}
