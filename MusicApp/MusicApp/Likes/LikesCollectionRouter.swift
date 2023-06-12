//
//  LikesMusicCollectionRouter.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import Foundation

protocol LikesCollectionRouterProtocol
{
    func goToDetailsScreen(for track: Track)
}

final class LikesCollectionRouter: BaseRouter, LikesCollectionRouterProtocol
{
    func goToDetailsScreen(for track: Track) {
        let detailModel = DetailViewModel(selectedTrack: track)
        let detailVC = DetailViewController(model: detailModel)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
