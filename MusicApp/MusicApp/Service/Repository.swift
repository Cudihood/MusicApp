//
//  Repository.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import Foundation

protocol TrackRepositoryProtocol
{
    func saveTrack(track: Track)
    func loadTracks() -> [Track]?
    func deleteTrack(track: Track)
    func searchTrack(trackName: String, comletion: @escaping (Results?) -> Void)
    func isTrackSaved(track: Track) -> Bool
}

final class TrackRepository: TrackRepositoryProtocol
{
    private let networkDataFetcher = NetworkDataFetcher()
    private let trackDataManager = TrackDataManager()
    
    func saveTrack(track: Track) {
        trackDataManager.saveTrack(track: track)
    }
    
    func loadTracks() -> [Track]? {
        trackDataManager.loadTracks()
    }
    
    func deleteTrack(track: Track) {
        trackDataManager.deleteTrack(track: track)
    }
    
    func searchTrack(trackName: String, comletion: @escaping (Results?) -> Void) {
        networkDataFetcher.fetchTrack(trackName: trackName) { data in
            let decode = self.decodeJSON(type: Results.self, from: data)
            comletion(decode)
        }
    }
    
    func isTrackSaved(track: Track) -> Bool {
        if let savedTracks = trackDataManager.loadTracks() {
            return savedTracks.contains { $0.trackID == track.trackID }
        }
        return false
    }
}

extension TrackRepository {
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        //        let str = String(decoding: data, as: UTF8.self)
        do {
            let objects = try decoder.decode(type, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
