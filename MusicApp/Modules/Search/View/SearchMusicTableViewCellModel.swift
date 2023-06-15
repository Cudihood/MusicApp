//
//  SearchMusicTableViewCellModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit
import Kingfisher

struct SearchMusicTableViewCellModel {
    
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
}
