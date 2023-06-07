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
    var isLoading: Bool { get set }
    var tracksUpdateHandler: (() -> Void)? { get set }
    var updateLoadingState: (() -> Void)? { get set }
    func fetchTrack(trackName: String)
}

final class SearchMusicTableViewModel: SearchMusicTableViewModelProtocol
{
    var tracksUpdateHandler: (() -> Void)?
    var updateLoadingState:(() -> Void)?
    
    var tracks = [Track]() {
        didSet{
            tracksUpdateHandler?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingState?()
        }
    }
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    func fetchTrack(trackName: String) {
        networkDataFetcher.fetchTrack(trackName: trackName) { [weak self] (searchResults) in
            guard let self = self, let fetchedTrack = searchResults else {
                self?.tracks = []
                return
            }
            self.tracks = fetchedTrack.results
        }
    }
}
