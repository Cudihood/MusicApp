//
//  DetailViewModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit
import Kingfisher

protocol DetailViewModelProtocol
{
    var selectedTrack: Track { get set }
    var trackIsLiked: Bool { get set }
    var trackLikeUpdateHandler: ((Bool) -> Void)? { get set }
    
    func likeButtonTapped()
    func fetchImageTrack(completion: @escaping (UIImage?) -> Void)
}

class DetailViewModel: DetailViewModelProtocol
{
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


//let artistID: Int?
////    let collectionID: Int?
//let trackID: Int?
//let artistName: String?
////    let collectionName: String?
//let trackName: String?
//let artistViewURL: String?
////    let collectionViewURL: String?
//let trackViewURL: String?
//let previewURL: String?
//let artworkUrl100: String?
//let releaseDate: String?
//let trackTimeMillis: Int?
//let primaryGenreName: String?
//
//init(track: Track) {
//    self.artistID = track.artistID
////        self.collectionID = track.collectionID
//    self.trackID = track.trackID
//    self.artistName = track.artistName
////        self.collectionName = track.collectionName
//    self.trackName = track.trackName
//    self.artistViewURL = track.artistViewURL
////        self.collectionViewURL = track.collectionViewURL
//    self.trackViewURL = track.trackViewURL
//    self.previewURL = track.previewURL
//    self.artworkUrl100 = track.artworkUrl100
//    self.releaseDate = track.releaseDate
//    self.trackTimeMillis = track.trackTimeMillis
//    self.primaryGenreName = track.primaryGenreName
//}
