//
//  UIImage+addImage.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 15.06.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func addImageFrom(url: URL?, options: KingfisherOptionsInfo? = [.cacheOriginalImage]) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, options: options)
    }
}
