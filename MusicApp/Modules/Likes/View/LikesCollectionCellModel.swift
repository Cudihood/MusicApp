//
//  LikesMusicCollectionCellModel.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import UIKit

struct LikesCollectionCellModel {
    private let track: Track?
    
    init(track: Track?) {
        self.track = track
    }
    
    var artworkUrl100: URL? {
        return URL(string: track?.artworkUrl100 ?? "")
    }
    
    var trackTitle: String {
        return track?.trackName ?? ""
    }
    
    var artistName: String {
        return track?.artistName ?? ""
    }
}
