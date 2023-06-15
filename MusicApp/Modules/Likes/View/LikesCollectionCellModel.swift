//
//  LikesMusicCollectionCellModel.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import UIKit

struct LikesCollectionCellModel {
    
    let imageTrack: UIImage?
    let trackName: String?
    let artistName: String?
    
    init(track: Track?) {
        self.imageTrack = UIImage(data: track?.artwork100 ?? Data())
        self.trackName = track?.trackName
        self.artistName = track?.artistName
    }
}
