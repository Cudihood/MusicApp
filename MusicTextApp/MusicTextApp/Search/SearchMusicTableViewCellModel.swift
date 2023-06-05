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
    
    init(model: Result?) {
        self.image = UIImage()
        self.artist = model?.artistName
        self.track = model?.trackName
        
    }
}
