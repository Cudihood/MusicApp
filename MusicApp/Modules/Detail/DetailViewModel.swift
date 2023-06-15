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
    func fetchImageTrack(completion: @escaping (UIImage?) -> Void)
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
    
    func fetchImageTrack(completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: selectedTrack.artworkUrl100 ?? "") else {
            completion(nil)
            return
        }
        
        let resours = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resours) { result in
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
