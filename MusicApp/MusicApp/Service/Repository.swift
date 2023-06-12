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
}

final class TrackRepository: TrackRepositoryProtocol
{
    private let networkDataFetcher = NetworkDataFetcher()
    private let trackDataManager = TrackDataManager()
    
//    init(networkDataFetcher: NetworkDataFetcher, trackDataManager: TrackDataManager) {
//        self.networkDataFetcher = networkDataFetcher
//        self.trackDataManager = trackDataManager
//    }
    
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
        networkDataFetcher.fetchTrack(trackName: trackName) { results in
            comletion(results)
        }
    }
    
    private func isTrackSaved(track: Track) -> Bool {
        if let savedTracks = trackDataManager.loadTracks() {
            return savedTracks.contains { $0.trackID == track.trackID }
        }
        return false
    }
}
