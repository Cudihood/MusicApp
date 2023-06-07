//
//  SearchMusicTableViewCellModel.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 31.05.2023.
//

import UIKit

struct SearchMusicTableViewCellModel
{
    let image: UIImage?
    let artist: String?
    let track: String?
    
    init(model: Track?) {
        self.image = UIImage(systemName: "person.fill")
        self.artist = model?.artistName
        self.track = model?.trackName
        
    }
}
