//
//  MainTabBarController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let repository = TrackRepository()
        let searchVC = SearchMusicTableViewController.viewController(trackRepository: repository)
//        searchVC.setViewModel(model: SearchMusicTableViewModel(trackRepository: repository))
//        searchVC.setRouter(router: SearchMusicTableRouter(viewController: searchVC))
        
        let likesVC = LikesCollectionViewController()
        likesVC.setViewModel(model: LikesCollectionViewModel(trackRepository: repository))
        likesVC.setRouter(router: LikesCollectionRouter(viewController: likesVC))
        
        viewControllers = [generateNavigationController(rootViewController: searchVC, title: "Поиск", image: UIImage(systemName: "magnifyingglass")), generateNavigationController(rootViewController: likesVC, title: "Любимые", image: UIImage(systemName: "heart"))]
    }
    
    func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Color.blue,
            .font: UIFont.preferredFont(forTextStyle: .title1)
            ]
        navigationVC.navigationBar.titleTextAttributes = titleTextAttributes
        return navigationVC
    }
}
