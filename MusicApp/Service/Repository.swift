//
//  Repository.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import Foundation

protocol TrackRepositoryProtocol {
    func saveTrack(track: Track)
    func loadTracks() -> [Track]?
    func deleteTrack(track: Track)
    func searchTrack(trackName: String, comletion: @escaping (Results?, Error?) -> Void)
    func isTrackSaved(track: Track) -> Bool
}

final class TrackRepository: TrackRepositoryProtocol {
    private let networkService = NetworkService()
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
    
    func searchTrack(trackName: String, comletion: @escaping (Results?, Error?) -> Void) {
        networkService.request(trackName: trackName) { data, error in
            if let error = error {
                comletion(nil, error)
            }
            let decode = self.decodeJSON(type: Results.self, from: data)
            comletion(decode, nil)
        }
    }
    
    func isTrackSaved(track: Track) -> Bool {
        guard let trackID = track.trackID else {
            return false
        }
        return trackDataManager.searchTrackByID(trackID: trackID) != nil
    }
}

private extension TrackRepository {
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
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
