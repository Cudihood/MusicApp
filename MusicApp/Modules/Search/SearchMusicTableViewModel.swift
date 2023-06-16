//
//  SearchMusicTableViewModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit

protocol SearchMusicTableViewModelProtocol {
    var tracks: [Track] { get }
    var tracksUpdateHandler: (() -> Void)? { get set }
    var showAlert: ((String) -> Void)? { get set }
    
    func fetchTrack(trackName: String)
    func resetSearch()
}

final class SearchMusicTableViewModel: SearchMusicTableViewModelProtocol {
    var tracksUpdateHandler: (() -> Void)?
    var showAlert: ((String) -> Void)?
    
    private(set) var tracks = [Track]() {
        didSet{
            tracksUpdateHandler?()
        }
    }
    
    private let trackRepository: TrackRepositoryProtocol
    
    init(trackRepository: TrackRepositoryProtocol) {
        self.trackRepository = trackRepository
    }
    
    func resetSearch() {
        tracks = []
    }
    
    func fetchTrack(trackName: String) {
        trackRepository.searchTrack(trackName: trackName) { [weak self] (searchResults, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert?(error.localizedDescription)
                return
            }
            
            guard let searchResults = searchResults else {
                self.tracks = []
                return
            }
            self.tracks = searchResults.results
        }
    }
}
