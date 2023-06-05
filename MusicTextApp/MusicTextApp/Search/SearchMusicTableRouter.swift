//
//  SearchMusicTableRouter.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import Foundation

protocol SearchMusicTableRouterProtocol
{
//    func goToDetailsScreen(for music: SearchMusicTableViewModel)
    func goToDetailsScreen()
}

class SearchMusicTableRouter: BaseRouter, SearchMusicTableRouterProtocol
{
    func goToDetailsScreen() {
        let detailVC = DetailViewController()
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
