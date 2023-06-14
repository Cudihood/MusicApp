//
//  LikesCollectionViewModel.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import Foundation

protocol LikesCollectionViewModelProtocol
{
    var likesTrack: [Track] { get }
}

final class LikesCollectionViewModel: LikesCollectionViewModelProtocol
{
    var likesTrack: [Track] {
        trackRepository.loadTracks() ?? []
    }
    
    private let trackRepository: TrackRepositoryProtocol
    
    init(trackRepository: TrackRepositoryProtocol) {
        self.trackRepository = trackRepository
    }
}
