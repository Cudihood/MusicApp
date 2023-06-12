//
//  SearchMusicTableRouter.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import Foundation

protocol SearchMusicTableRouterProtocol
{
    func goToDetailsScreen(for track: Track)
}

final class SearchMusicTableRouter: BaseRouter, SearchMusicTableRouterProtocol
{
    func goToDetailsScreen(for track: Track) {
        let detailModel = DetailViewModel(selectedTrack: track)
        let detailVC = DetailViewController(model: detailModel)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
