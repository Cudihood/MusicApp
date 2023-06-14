//
//  SearchMusicTableViewCellModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit
import Kingfisher

struct SearchMusicTableViewCellModel
{
    private let track: Track?
    
    init(track: Track?) {
        self.track = track
    }
    
    var artworkUrl60: URL? {
        return URL(string: track?.artworkUrl60 ?? "")
    }
    
    var trackTitle: String {
        return track?.trackName ?? ""
    }
    
    var artistName: String {
        return track?.artistName ?? ""
    }
    
    func fetchImageTrack(completion: @escaping (UIImage?) -> Void) {
        guard let url = artworkUrl60 else {
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
