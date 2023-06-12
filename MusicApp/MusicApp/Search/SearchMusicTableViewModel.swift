//
//  SearchMusicTableViewModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit

protocol SearchMusicTableViewModelProtocol
{
    var tracks: [Track] { get set }
    var tracksUpdateHandler: (() -> Void)? { get set }
    func fetchTrack(trackName: String)
}

final class SearchMusicTableViewModel: SearchMusicTableViewModelProtocol
{
    var tracks = [Track]() {
        didSet{
            tracksUpdateHandler?()
        }
    }
    
    var tracksUpdateHandler: (() -> Void)?
    
    private let trackRepository: TrackRepositoryProtocol
    
    init(trackRepository: TrackRepositoryProtocol) {
        self.trackRepository = trackRepository
    }
    
    func fetchTrack(trackName: String) {
        trackRepository.searchTrack(trackName: trackName) { [weak self] (searchResults) in
            guard let self = self, let fetchedTrack = searchResults else {
                self?.tracks = []
                return
            }
            self.tracks = fetchedTrack.results
        }
    }
}
