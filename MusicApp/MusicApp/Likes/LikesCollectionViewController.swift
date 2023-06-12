//
//  FavoriteMusicTableViewController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit

class LikesCollectionViewController: UIViewController
{
    private var viewModel: LikesCollectionViewModelProtocol?
    private var router: LikesCollectionRouterProtocol?
    
    private let customView = LikesCollectionView()
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tracks = viewModel?.likesTrack
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.customView.reload()
    }
    
    func setRouter(router: LikesCollectionRouterProtocol?) {
        self.router = router
    }
    
    func setViewModel(model: LikesCollectionViewModelProtocol?) {
        self.viewModel = model
    }
}

private extension LikesCollectionViewController
{
    func configure() {
        self.title = "Любимые"
        setupTapItemHandlers()
        customView.setModel(model: viewModel)
    }
    
    func setupTapItemHandlers() {
        customView.tapItemHandlet = { [weak self] track in
            guard let self = self, let track = track else { return }
            self.router?.goToDetailsScreen(for: track)
        }
    }
}
