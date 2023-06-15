//
//  LikesMusicCollectionCellModel.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import UIKit

struct LikesCollectionCellModel {
    
//    let imageTrack: UIImage?
//    let trackName: String?
//    let artistName: String?
//
//    init(track: Track?) {
//        self.imageTrack = UIImage(data: track?.artwork100 ?? Data())
//        self.trackName = track?.trackName
//        self.artistName = track?.artistName
//    }
    private let track: Track?
    
    init(track: Track?) {
        self.track = track
    }
    
    var artwork100: UIImage? {
        return UIImage(data: track?.artwork100 ?? Data())
    }
    
    var trackTitle: String {
        return track?.trackName ?? ""
    }
    
    var artistName: String {
        return track?.artistName ?? ""
    }
}
