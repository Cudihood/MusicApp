//
//  LikesMusicCollectionRouter.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import Foundation

protocol LikesCollectionRouterProtocol {
    func goToDetailsScreen(for track: Track)
}

final class LikesCollectionRouter: BaseRouter, LikesCollectionRouterProtocol {
    func goToDetailsScreen(for track: Track) {
        let detailVC = DetailViewController.viewController(selectedTrack: track)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
