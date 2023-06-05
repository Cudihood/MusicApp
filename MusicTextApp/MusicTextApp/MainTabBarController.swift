//
//  MainTabBarController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let searchVC = SearchMusicTableViewController()
        searchVC.viewModel = SearchMusicTableViewModel()
        searchVC.router = SearchMusicTableRouter(viewController: searchVC)

        viewControllers = [generateNavigationController(rootViewController: searchVC, title: "Поиск", image: UIImage(systemName: "magnifyingglass") ?? UIImage())]
    }
    
    func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
