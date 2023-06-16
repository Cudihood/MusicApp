//
//  DetailViewModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit
import Kingfisher

protocol DetailViewModelProtocol {
    
    var selectedTrack: Track { get set }
    var trackIsLiked: Bool { get set }
    var trackLikeUpdateHandler: ((Bool) -> Void)? { get set }
    
    func likeButtonTapped()
    func updateLikeStatus()
}

final class DetailViewModel: DetailViewModelProtocol {
    
    var trackLikeUpdateHandler: ((Bool) -> Void)?
    var selectedTrack: Track
    
    var trackIsLiked: Bool = false {
        didSet {
            trackLikeUpdateHandler?(trackIsLiked)
        }
    }
    
    private var repository = TrackRepository()
    
    init(selectedTrack: Track) {
        self.selectedTrack = selectedTrack
    }
    
    func updateLikeStatus() {
        trackIsLiked = repository.isTrackSaved(track: selectedTrack)
    }

    func likeButtonTapped() {
        if trackIsLiked {
            repository.deleteTrack(track: selectedTrack)
        } else {
            repository.saveTrack(track: selectedTrack)
        }
        trackIsLiked.toggle()
    }
}
