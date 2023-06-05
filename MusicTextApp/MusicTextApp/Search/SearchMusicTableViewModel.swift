//
//  SearchMusicTableViewModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit

protocol SearchMusicTableViewModelProtocol
{
    var tracks: [Result] { get }
    var tracksUpdateHandler: (() -> Void)? { get set }
    
    func fetchTrack(trackName: String)
}

final class SearchMusicTableViewModel: SearchMusicTableViewModelProtocol
{
    private var networkDataFetcher = NetworkDataFetcher()
    
    var tracks = [Result]() {
        didSet{
            tracksUpdateHandler?()
        }
    }
 
    var tracksUpdateHandler: (() -> Void)?
    
    func fetchTrack(trackName: String) {
        networkDataFetcher.fetchTrack(trackName: trackName) { [weak self] (searchResults) in
            guard let self = self, let fetchedTrack = searchResults else { return }
            if let result = fetchedTrack.results {
                self.tracks = result
            }
        }
    }
}
